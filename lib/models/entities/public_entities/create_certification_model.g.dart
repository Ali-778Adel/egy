// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_certification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCertificationModel _$CreateCertificationModelFromJson(
        Map<String, dynamic> json) =>
    CreateCertificationModel(
      lang: json['lang'] as String?,
      orderRequestNo: json['OrderRequestNo'] as String?,
      mobileNo: json['MobileNo'] as String?,
      custName: json['CustName'] as String?,
      certificateTypeID: json['CertificateTypeID'] as int?,
      natid: json['Natid'] as String?,
      oRDDocuments: (json['ORDDocuments'] as List<dynamic>?)
          ?.map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateCertificationModelToJson(
        CreateCertificationModel instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'CustName': instance.custName,
      'MobileNo': instance.mobileNo,
      'Natid': instance.natid,
      'CertificateTypeID': instance.certificateTypeID,
      'OrderRequestNo': instance.orderRequestNo,
      'ORDDocuments': instance.oRDDocuments,
    };
