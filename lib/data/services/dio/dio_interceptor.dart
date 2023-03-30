import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:flutter/material.dart';
import '../../../di/dependency_injection.dart';
import '../../../models/utils/common.dart';
import '../../../repository/common_function/handle_dio_error_excptions.dart';
import '../network_info.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    if (await sl<NetworkInfo>().isConnected) {
      String headerMessage = "";
      options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');
      try {
        options.queryParameters.forEach(
          (k, v) => debugPrint(
            '► $k: $v',
          ),
        );
      } catch (_) {}
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyJson = encoder.convert(options.data);
        log.d(
          // ignore: unnecessary_null_comparison
          "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}\n\n"
          "Headers:\n"
          "$headerMessage\n"
          "❖ QueryParameters : \n"
          "Body: $prettyJson",
        );
      } catch (e) {
        log.e("Failed to extract json request $e");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) async {
    // if (dioError.type == DioErrorType) {
      if (!await sl<NetworkInfo>().isConnected) {
        sl<DioErrorsImpl>().dioErrorMessage =
            AppGeneralTrans.internetExceptionTxt.isEmpty?'لا يوجد اتصال بالانترنت':AppGeneralTrans.internetExceptionTxt;
      } else {
        sl<DioErrorsImpl>().dioErrorMessage =
            AppGeneralTrans.serverExceptionTxt;
      }
    // } else {
    //   sl<DioErrorsImpl>().dioErrorMessage = dioError.message!;
    // }
    log.e(
      "<-- ${dioError.message} ${dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}",
    );

    super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );
    super.onResponse(response, handler);
  }
}
