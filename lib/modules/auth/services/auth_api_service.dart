import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/api_constants.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final dynamic data;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? json['status'] ?? false,
      message: json['message'] ?? json['msg'] ?? '',
      data: json['data'],
    );
  }
}

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  factory AuthApiService() => _instance;
  AuthApiService._internal();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<RegisterResponse> registerProvider({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
    String role = 'provider',
  }) async {
    try {
      final Uri url = Uri.parse(ApiConstants.register);

      final Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
        'location': location,
      };

      final response = await http
          .post(
            url,
            headers: _headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } catch (e) {
      return RegisterResponse(
        success: false,
        message: 'Network error: ${e.toString().replaceAll('Exception: ', '')}',
      );
    }
  }

  RegisterResponse _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    final String body = response.body;

    try {
      final Map<String, dynamic> decoded = jsonDecode(body);

      if (statusCode >= 200 && statusCode < 300) {
        return RegisterResponse.fromJson(decoded);
      } else {
        final errorMsg = decoded['message'] ??
            decoded['msg'] ??
            decoded['error'] ??
            'Request failed with status $statusCode';
        return RegisterResponse(
          success: false,
          message: errorMsg is List ? errorMsg.join(', ') : errorMsg.toString(),
        );
      }
    } catch (_) {
      if (statusCode >= 200 && statusCode < 300) {
        return RegisterResponse(
          success: true,
          message: 'Operation successful',
        );
      }
      return RegisterResponse(
        success: false,
        message: 'Server error (status $statusCode)',
      );
    }
  }
}
