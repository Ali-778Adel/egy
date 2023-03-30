import 'package:flutter/foundation.dart';

class EnumToString {
  String convertToString(var value) {
    return describeEnum(value);
  }

  T fromString<T>(List<T> enumValues, String value) {
    return enumValues.firstWhere((e) => convertToString(e) == value);
  }
}
