import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_config.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';

/// Thin wrapper around [Dio]. Registered once in [InitialBinding] and shared
/// by every repository.
class ApiClient {
  ApiClient({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? AppConfig.baseUrl,
            connectTimeout: AppConfig.connectTimeout,
            receiveTimeout: AppConfig.receiveTimeout,
            headers: <String, dynamic>{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(AuthInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) {
    return _send(() => _dio.get<dynamic>(path, queryParameters: query));
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) {
    return _send(() => _dio.post<dynamic>(path, data: body, queryParameters: query));
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? body,
  }) {
    return _send(() => _dio.put<dynamic>(path, data: body));
  }

  Future<Response<dynamic>> delete(String path) {
    return _send(() => _dio.delete<dynamic>(path));
  }

  Future<Response<dynamic>> _send(Future<Response<dynamic>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
