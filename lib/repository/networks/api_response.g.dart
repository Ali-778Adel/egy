// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      ver: json['Ver'] as String?,
      data: _$nullableGenericFromJson(json['Data'], fromJsonT),
      message: json['Message'] as String?,
      userId: json['UserId'] as String?,
      success: json['Success'] as bool?,
      errorCode: json['error_code'] as int?,
      forceUpdateMsg: json['ForceUpdateMsg'] as String?,
      optionalUpdateMsg: json['OptionalUpdateMsg'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'ForceUpdateMsg': instance.forceUpdateMsg,
      'OptionalUpdateMsg': instance.optionalUpdateMsg,
      'Ver': instance.ver,
      'error_code': instance.errorCode,
      'Success': instance.success,
      'Message': instance.message,
      'UserId': instance.userId,
      'Data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
