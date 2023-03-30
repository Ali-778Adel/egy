
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {


  @JsonKey(name: 'ForceUpdateMsg')
  String? forceUpdateMsg;

  @JsonKey(name: 'OptionalUpdateMsg')
  String? optionalUpdateMsg;

  @JsonKey(name: 'Ver')
  String? ver;

  @JsonKey(name: 'error_code')
  int? errorCode;

  @JsonKey(name: 'Success')
  bool? success;

  @JsonKey(name: 'Message')
  String? message;

  @JsonKey(name: 'UserId')
  String? userId;

  @JsonKey(name: 'Data')
  T? data;

  ApiResponse({this.ver, this.data, this.message, this.userId , this.success , this.errorCode , this.forceUpdateMsg , this.optionalUpdateMsg});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ApiResponseFromJson<T>(json, fromJsonT);

  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T value) toJsonT,
      ) {
    return _$ApiResponseToJson<T>(this, toJsonT);
  }
}

enum ApiStatus {
  success,
  fail,
  notFound,
  parametersNotValid,
  applicationException,
  sessionExists,
  unauthorized,
  oTPRequired,
  emailVerifyRequired
}
