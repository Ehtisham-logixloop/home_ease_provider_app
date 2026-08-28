import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/base_api_client.dart';
import '../../../core/network/token_storage.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final String? userId;
  final String? role;
  final Map<String, dynamic>? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.userId,
    this.role,
    this.user,
  });

  factory LoginResponse.fromApiResponse(ApiResponse response) {
    final data = response.data is Map<String, dynamic>
        ? response.data as Map<String, dynamic>
        : <String, dynamic>{};

    String? token;
    String? userId;
    String? role;
    Map<String, dynamic>? user;

    if (response.success) {
      token = data['token']?.toString() ?? data['accessToken']?.toString();
      userId = data['userId']?.toString() ??
          data['id']?.toString() ??
          (data['user'] is Map<String, dynamic>
              ? data['user']['id']?.toString()
              : null);
      role = data['role']?.toString() ??
          (data['user'] is Map<String, dynamic>
              ? data['user']['role']?.toString()
              : null);
      user = data['user'] is Map<String, dynamic>
          ? data['user'] as Map<String, dynamic>
          : (data.isNotEmpty ? data : null);
    }

    return LoginResponse(
      success: response.success,
      message: response.message,
      token: token,
      userId: userId,
      role: role,
      user: user,
    );
  }
}

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  factory AuthApiService() => _instance;
  AuthApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  // ================= REGISTER =================
  Future<ApiResponse> registerProvider({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
    String? category,
    String? cnic,
    String role = 'provider',
  }) async {
    return _client.post(
      ApiConstants.register,
      requireAuth: false,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
        'location': location,
        if (category != null) 'category': category,
        if (cnic != null) 'cnic': cnic,
      },
    );
  }

  // ================= LOGIN =================
  Future<LoginResponse> loginProvider({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      ApiConstants.login,
      requireAuth: false,
      body: {
        'email': email,
        'password': password,
      },
    );

    final loginResult = LoginResponse.fromApiResponse(response);

    if (loginResult.success &&
        loginResult.token != null &&
        loginResult.userId != null) {
      await TokenStorage().saveAuthInfo(
        token: loginResult.token!,
        userId: loginResult.userId!,
        role: loginResult.role ?? 'provider',
      );
    }

    return loginResult;
  }

  // ================= FORGOT PASSWORD: SEND OTP =================
  Future<ApiResponse> sendOtp({
    required String email,
  }) async {
    return _client.post(
      ApiConstants.sendOtp,
      requireAuth: false,
      body: {
        'email': email,
      },
    );
  }

  // ================= FORGOT PASSWORD: VERIFY OTP =================
  Future<ApiResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return _client.post(
      ApiConstants.verifyOtp,
      requireAuth: false,
      body: {
        'email': email,
        'otp': otp,
      },
    );
  }

  // ================= RESET PASSWORD =================
  Future<ApiResponse> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return _client.post(
      ApiConstants.resetPassword,
      requireAuth: false,
      body: {
        'email': email,
        'otp': otp,
        'password': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }

  // ================= LOGOUT =================
  Future<ApiResponse> logout() async {
    final response = await _client.post(
      ApiConstants.logout,
      requireAuth: true,
    );
    await TokenStorage().clearAll();
    return response;
  }
}
