import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {



  @JsonKey(name: 'OrderStatus')
  int? orderStatus;

  @JsonKey(name: 'CertificateTypeName')
  String? certificateTypeName;


  @JsonKey(name: 'PaymentUniqueID')
  String? paymentUniqueID;



  @JsonKey(name: 'Pay_Amount')
  double? payAmount;

  @JsonKey(name: 'SampleDownloadLink')
  String? sampleDownloadLink;


  @JsonKey(name: 'ReviewNotes')
  String? reviewNotes;

  @JsonKey(name: 'lang')
  String? lang;

  @JsonKey(name: 'CustName')
  String? custName;


  @JsonKey(name: 'MobileNo')
  String? mobileNo;

  @JsonKey(name: 'NatID')
  String? natID;

  @JsonKey(name: 'CertificateTypeID')
  String? certificateTypeID;


  @JsonKey(name: 'OrderRequestNo')
  String? orderRequestNo;

  @JsonKey(name: 'ORDDocuments')
  List<DocumentModel>? oRDDocuments;

  OrderModel({
      this.lang,
      this.orderRequestNo,
    this.mobileNo,
    this.custName,
    this.certificateTypeID,
    this.oRDDocuments,
    this.natID,
    this.sampleDownloadLink,
    this.certificateTypeName,
    this.orderStatus,
    this.payAmount,
    this.paymentUniqueID,
    this.reviewNotes

  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

