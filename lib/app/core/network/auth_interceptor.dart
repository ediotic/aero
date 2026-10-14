import 'package:dio/dio.dart';

/// Holds the access token in memory. Swap for secure storage when login is
/// added.
class TokenStore {
  TokenStore._();

  static String? token;
}

/// Adds the bearer token to every request when one is available.
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = TokenStore.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
