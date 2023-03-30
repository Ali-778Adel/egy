import 'package:flutter/material.dart';

import '../../main.dart';

showDefaultSnack(String txt) {
  final snackBar = SnackBar(
    content: Text(txt),
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}
