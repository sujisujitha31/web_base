import 'package:dio/dio.dart';

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        '[DIO] Request: ${options.method.toString()} ${options.uri.toString()}');
    print('[DIO] Headers: ${options.headers["Authorization"]}');
    if (options.data != null) {
      print('[DIO] Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[DIO] Response: ${response.statusCode}');
    print('[DIO] Response messge: ${response.statusMessage}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('[DIO] Error: ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
