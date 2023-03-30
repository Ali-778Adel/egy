// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    DocumentModel(
      oRDName: json['ORDName'] as String?,
      oRDBase64Doc: json['ORDBase64Doc'] as String?,
    )
      ..filePath = json['filePath'] as String?
      ..error = json['error'] as String?
      ..isImage = json['isImage'] as bool;

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'ORDName': instance.oRDName,
      'ORDBase64Doc': instance.oRDBase64Doc,
      'filePath': instance.filePath,
      'error': instance.error,
      'isImage': instance.isImage,
    };
