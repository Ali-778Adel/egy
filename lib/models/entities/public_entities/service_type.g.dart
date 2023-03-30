// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTypeData _$ServiceTypeDataFromJson(Map<String, dynamic> json) =>
    ServiceTypeData(
      serviceTypeID: json['ServiceTypeID'] as int?,
      serviceTypeName: json['ServiceTypeName'] as String?,
    );

Map<String, dynamic> _$ServiceTypeDataToJson(ServiceTypeData instance) =>
    <String, dynamic>{
      'ServiceTypeID': instance.serviceTypeID,
      'ServiceTypeName': instance.serviceTypeName,
    };
