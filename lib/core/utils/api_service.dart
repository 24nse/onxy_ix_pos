import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  final String baseUrl;

  ApiService({required this.dio, required this.baseUrl});

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.post(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.put(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.delete(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }
} 