import 'package:flutter/material.dart';

class DioErrorsImpl {
  String errorMessage = 'unknown error,please tyr again later';

  String get dioErrorMessage => errorMessage;

  set dioErrorMessage(String message) {
    errorMessage = message;
    debugPrint('message :$message');
  }
}
