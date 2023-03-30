// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationTypeModel _$CertificationTypeModelFromJson(
        Map<String, dynamic> json) =>
    CertificationTypeModel(
      certificateTypeID: json['CertificateTypeID'] as int?,
      sampleDownloadLink: json['SampleDownloadLink'] as String?,
      requiredDocumentsNote: json['RequiredDocumentsNote'] as String?,
      certificateTypeName: json['CertificateTypeName'] as String?,
    );

Map<String, dynamic> _$CertificationTypeModelToJson(
        CertificationTypeModel instance) =>
    <String, dynamic>{
      'CertificateTypeName': instance.certificateTypeName,
      'RequiredDocumentsNote': instance.requiredDocumentsNote,
      'SampleDownloadLink': instance.sampleDownloadLink,
      'CertificateTypeID': instance.certificateTypeID,
    };
