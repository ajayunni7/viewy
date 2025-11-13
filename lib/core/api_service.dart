import 'package:dio/dio.dart';

import 'package:viewy_test/core/token_storage.dart';

const String _defaultBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://projects.viewydigital.com/demoapi/v1',
);

class ApiService {
  ApiService._internal()
      : _tokenStorage = TokenStorage(),
        _dio = Dio(
          BaseOptions(
            baseUrl: _defaultBaseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            responseType: ResponseType.json,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _authToken ?? await _tokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  final Dio _dio;
  final TokenStorage _tokenStorage;
  String? _authToken;

  Dio get client => _dio;

  String? get authToken => _authToken;

  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  Future<void> loadPersistedToken() async {
    final token = await _tokenStorage.getToken();
    if (token != null && token.isNotEmpty) {
      await setAuthToken(token, persist: false);
    }
  }

  Future<void> setAuthToken(String token, {bool persist = true}) async {
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
    if (persist) {
      await _tokenStorage.saveToken(token);
    }
  }

  Future<void> clearAuthToken() async {
    _authToken = null;
    _dio.options.headers.remove('Authorization');
    await _tokenStorage.clearToken();
  }

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  String get baseUrl => _dio.options.baseUrl;
}
