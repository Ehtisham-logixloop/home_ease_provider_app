import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import 'api_response.dart';
import 'token_storage.dart';

class BaseApiClient {
  static final BaseApiClient _instance = BaseApiClient._internal();
  factory BaseApiClient() => _instance;
  BaseApiClient._internal();

  Map<String, String> get _baseHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> _getAuthHeaders() async {
    final headers = Map<String, String>.from(_baseHeaders);
    final token = await TokenStorage().getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  ApiResponse _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    final String body = response.body;

    try {
      final decoded = jsonDecode(body);

      if (statusCode >= 200 && statusCode < 300) {
        return ApiResponse(
          success: true,
          statusCode: statusCode,
          message: decoded['message']?.toString() ??
              decoded['msg']?.toString() ??
              'Success',
          data: decoded['data'] ?? decoded,
        );
      } else {
        final errorMsg = decoded['message']?.toString() ??
            decoded['msg']?.toString() ??
            decoded['error']?.toString() ??
            (decoded['errors'] is List
                ? (decoded['errors'] as List).join(', ')
                : null) ??
            'Request failed with status $statusCode';
        return ApiResponse(
          success: false,
          statusCode: statusCode,
          message: errorMsg,
          data: decoded,
        );
      }
    } catch (_) {
      if (statusCode >= 200 && statusCode < 300) {
        return ApiResponse(
          success: true,
          statusCode: statusCode,
          message: 'Operation successful',
          data: null,
        );
      }
      return ApiResponse(
        success: false,
        statusCode: statusCode,
        message: 'Server error (status $statusCode)',
        data: null,
      );
    }
  }

  ApiResponse _handleError(Object e) {
    String message;
    if (e is SocketException) {
      message = 'No internet connection. Please check your network.';
    } else if (e is http.ClientException) {
      message = 'Network error: ${e.message.replaceAll('Exception: ', '')}';
    } else if (e.toString().contains('TimeoutException')) {
      message = 'Request timed out. Please try again.';
    } else {
      message = 'Unexpected error: ${e.toString().replaceAll('Exception: ', '')}';
    }
    return ApiResponse(
      success: false,
      statusCode: 0,
      message: message,
      data: null,
    );
  }

  Future<ApiResponse> get(
    String url, {
    Map<String, String>? queryParams,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final headers =
          requireAuth ? await _getAuthHeaders() : _baseHeaders;

      final response = await http
          .get(uri, headers: headers)
          .timeout(timeout ?? ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> post(
    String url, {
    Map<String, dynamic>? body,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      final headers =
          requireAuth ? await _getAuthHeaders() : _baseHeaders;

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout ?? ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> put(
    String url, {
    Map<String, dynamic>? body,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      final headers =
          requireAuth ? await _getAuthHeaders() : _baseHeaders;

      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout ?? ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> patch(
    String url, {
    Map<String, dynamic>? body,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      final headers =
          requireAuth ? await _getAuthHeaders() : _baseHeaders;

      final response = await http
          .patch(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout ?? ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> delete(
    String url, {
    Map<String, dynamic>? body,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      final headers =
          requireAuth ? await _getAuthHeaders() : _baseHeaders;

      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout ?? ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> multipartPost(
    String url, {
    Map<String, String>? fields,
    List<MultipartFileItem>? files,
    bool requireAuth = true,
    Duration? timeout,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      if (requireAuth) {
        final token = await TokenStorage().getToken();
        if (token != null && token.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }
      }
      request.headers['Accept'] = 'application/json';

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        for (final file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(
              file.field,
              file.filePath,
            ),
          );
        }
      }

      final streamedResponse = await request
          .send()
          .timeout(timeout ?? ApiConstants.connectionTimeout);
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
}

class MultipartFileItem {
  final String field;
  final String filePath;
  final String? mimeType;

  MultipartFileItem({
    required this.field,
    required this.filePath,
    this.mimeType,
  });
}
