import 'package:dio/dio.dart';

class UpdateUserDataEvent{
  final FormData?requestBody;
  UpdateUserDataEvent({this.requestBody});
}