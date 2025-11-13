import 'package:dio/dio.dart';

import 'package:viewy_test/core/api_service.dart';

class AuthService {
  AuthService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  Future<String> login({required String email, required String password}) async {
    try {
      final response = await _apiService.client.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = _extractToken(response);
      if (token == null || token.isEmpty) {
        throw const FormatException('Missing auth token in response');
      }

      await _apiService.setAuthToken(token);
      return token;
    } on DioException catch (dioError) {
      final errorMessage = dioError.response?.data is Map<String, dynamic>
          ? (dioError.response!.data['message'] as String?)
          : dioError.message;
      throw AuthException(errorMessage ?? 'Failed to login');
    }
  }

  String? _extractToken(Response<dynamic> response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      if (data['token'] is String) {
        return data['token'] as String;
      }
      if (data['data'] is Map<String, dynamic>) {
        final nested = data['data'] as Map<String, dynamic>;
        if (nested['token'] is String) {
          return nested['token'] as String;
        }
      }
    }
    return null;
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
