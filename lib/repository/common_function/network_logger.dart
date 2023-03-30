import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';

class NetworkLogger{
  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options , handler) => requestInterceptor(options),
          onResponse: (Response response , handler) => responseInterceptor(response)));
  }


  dynamic responseInterceptor(Response response) async {

    logger.e(response.statusCode.toString() +
        "--> ${ response.realUri.toString().toUpperCase() }");

    if (response.data != null) {
      logger.e("response: ->${response.data.toString()}");
    }
  }


  requestInterceptor(RequestOptions options) {

    logger.e(
        "--> ${options.method.toUpperCase() } ${options.baseUrl}  ${options.path}");
    logger.e("Headers:");
    options.headers.forEach((k, v) => logger.e('$k: $v'));
      logger.e("queryParameters:");
      options.queryParameters.forEach((k, v) => logger.e('$k: $v'));
    if (options.data != null) {
      logger.e("Body: ${options.data}");
    }
    logger.e(
        "--> END ${ options.method.toUpperCase()}");
  }
}