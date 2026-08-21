import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
    );
  }
}