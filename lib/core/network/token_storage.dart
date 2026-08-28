import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage() => _instance;
  TokenStorage._internal();

  static const String _keyToken = 'auth_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserRole = 'user_role';
  static const String _keyIsLoggedIn = 'is_logged_in';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveAuthInfo({
    required String token,
    required String userId,
    String role = 'provider',
  }) async {
    final prefs = await _prefsInstance;
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserRole, role);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  Future<String?> getToken() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyToken);
  }

  Future<String?> getUserId() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyUserId);
  }

  Future<String?> getUserRole() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyUserRole);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefsInstance;
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> clearAll() async {
    final prefs = await _prefsInstance;
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserRole);
    await prefs.setBool(_keyIsLoggedIn, false);
  }
}
