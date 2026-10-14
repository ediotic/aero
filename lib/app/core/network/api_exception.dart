import 'package:dio/dio.dart';

import '../constants/app_strings.dart';

/// A readable error thrown by [ApiClient]. Controllers can show [message]
/// directly to the user.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(AppStrings.errTimeout);
      case DioExceptionType.connectionError:
        return ApiException(AppStrings.errNoInternet);
      case DioExceptionType.cancel:
        return ApiException(AppStrings.errCancelled);
      case DioExceptionType.badResponse:
        final int? code = e.response?.statusCode;
        final dynamic data = e.response?.data;
        final String message = (data is Map && data['message'] is String)
            ? data['message'] as String
            : '${AppStrings.errServer} ($code)';
        return ApiException(message, statusCode: code);
      default:
        return ApiException(AppStrings.errGeneric);
    }
  }

  @override
  String toString() => message;
}
