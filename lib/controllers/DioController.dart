import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioController extends GetxController {
  late Dio _dio;
  final bool debug;

  Dio get dio => _dio;

  DioController({this.debug = false});

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://your-api-base-url.com',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ));

    if (debug) {
      _addLoggingInterceptors();
    }
  }

  void _addLoggingInterceptors() {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => print(object),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode}');
        print('Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Error: ${e.error}');
        print('Error Response: ${e.response}');
        return handler.next(e);
      },
    ));
  }
}
