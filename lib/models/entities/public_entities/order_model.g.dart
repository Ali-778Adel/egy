// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      lang: json['lang'] as String?,
      orderRequestNo: json['OrderRequestNo'] as String?,
      mobileNo: json['MobileNo'] as String?,
      custName: json['CustName'] as String?,
      certificateTypeID: json['CertificateTypeID'] as String?,
      oRDDocuments: (json['ORDDocuments'] as List<dynamic>?)
          ?.map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      natID: json['NatID'] as String?,
      sampleDownloadLink: json['SampleDownloadLink'] as String?,
      certificateTypeName: json['CertificateTypeName'] as String?,
      orderStatus: json['OrderStatus'] as int?,
      payAmount: (json['Pay_Amount'] as num?)?.toDouble(),
      paymentUniqueID: json['PaymentUniqueID'] as String?,
      reviewNotes: json['ReviewNotes'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'OrderStatus': instance.orderStatus,
      'CertificateTypeName': instance.certificateTypeName,
      'PaymentUniqueID': instance.paymentUniqueID,
      'Pay_Amount': instance.payAmount,
      'SampleDownloadLink': instance.sampleDownloadLink,
      'ReviewNotes': instance.reviewNotes,
      'lang': instance.lang,
      'CustName': instance.custName,
      'MobileNo': instance.mobileNo,
      'NatID': instance.natID,
      'CertificateTypeID': instance.certificateTypeID,
      'OrderRequestNo': instance.orderRequestNo,
      'ORDDocuments': instance.oRDDocuments,
    };
