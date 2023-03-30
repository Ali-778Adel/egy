import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_certification_model.g.dart';

@JsonSerializable()
class CreateCertificationModel {




  @JsonKey(name: 'lang')
  String? lang;

  @JsonKey(name: 'CustName')
  String? custName;


  @JsonKey(name: 'MobileNo')
  String? mobileNo;

  @JsonKey(name: 'Natid')
  String? natid;



  @JsonKey(name: 'CertificateTypeID')
  int? certificateTypeID;


  @JsonKey(name: 'OrderRequestNo')
  String? orderRequestNo;

  @JsonKey(name: 'ORDDocuments')
  List<DocumentModel>? oRDDocuments;

  CreateCertificationModel({
      this.lang,
      this.orderRequestNo,
    this.mobileNo,
    this.custName,
    this.certificateTypeID,
    this.natid,
    this.oRDDocuments,

  });

  factory CreateCertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCertificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCertificationModelToJson(this);
}

