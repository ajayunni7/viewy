import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  TokenStorage();

  static const _tokenKey = 'auth_token';

  String? _cachedToken;

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _cachedToken = token;
  }

  Future<String?> getToken() async {
    if (_cachedToken != null) {
      return _cachedToken;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    _cachedToken = token;
    return token;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _cachedToken = null;
  }
}
