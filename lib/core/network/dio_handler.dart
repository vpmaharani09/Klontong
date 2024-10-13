import 'package:dio/dio.dart';
import 'package:klontong/core/network/api_interceptors.dart';

class DioHandler {
  final String apiBaseUrl;

  DioHandler({required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}
