class ApiConstants {
  static const String baseUrl = 'http://192.168.0.101:5000';
  static const String apiBase = '$baseUrl/api';

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ================= AUTH =================
  static const String register = '$apiBase/auth/register';
  static const String login = '$apiBase/auth/login';
  static const String sendOtp = '$apiBase/auth/send-otp';
  static const String verifyOtp = '$apiBase/auth/verify-otp';
  static const String resetPassword = '$apiBase/auth/reset-password';
  static const String logout = '$apiBase/auth/logout';

  // ================= PROVIDER / PROFILE =================
  static const String profile = '$apiBase/provider/profile';
  static const String updateProfile = '$apiBase/provider/profile';
  static const String uploadProfileImage = '$apiBase/provider/profile-image';
  static const String toggleOnline = '$apiBase/provider/toggle-online';
  static const String uploadDocuments = '$apiBase/provider/documents';

  // ================= REQUESTS / HOME =================
  static const String requests = '$apiBase/requests';
  static const String requestDetail = '$apiBase/requests';

  // ================= OFFERS =================
  static const String offers = '$apiBase/offers';
  static const String sendOffer = '$apiBase/offers';
  static const String updateOffer = '$apiBase/offers';

  // ================= MESSAGES =================
  static const String messageThreads = '$apiBase/messages/threads';
  static const String chatMessages = '$apiBase/messages';
  static const String sendMessage = '$apiBase/messages';
}
