// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationData _$CertificationDataFromJson(Map<String, dynamic> json) =>
    CertificationData(
      certSerial: json['CertSerial'] as String?,
      restOfData: (json['RestOfData'] as List<dynamic>?)
          ?.map((e) => RestOfData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CertificationDataToJson(CertificationData instance) =>
    <String, dynamic>{
      'CertSerial': instance.certSerial,
      'RestOfData': instance.restOfData,
    };

RestOfData _$RestOfDataFromJson(Map<String, dynamic> json) => RestOfData(
      key: json['Key'] as String?,
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$RestOfDataToJson(RestOfData instance) =>
    <String, dynamic>{
      'Key': instance.key,
      'Value': instance.value,
    };
