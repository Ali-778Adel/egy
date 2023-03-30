import 'package:json_annotation/json_annotation.dart';
part 'certification_type_model.g.dart';

@JsonSerializable()
class CertificationTypeModel {






  @JsonKey(name: 'CertificateTypeName')
  String? certificateTypeName;

  @JsonKey(name: 'RequiredDocumentsNote')
  String? requiredDocumentsNote;

  @JsonKey(name: 'SampleDownloadLink')
  String? sampleDownloadLink;


  @JsonKey(name: 'CertificateTypeID')
  int? certificateTypeID;





  CertificationTypeModel({
      this.certificateTypeID,
    this.sampleDownloadLink,
    this.requiredDocumentsNote,
    this.certificateTypeName
  });

  factory CertificationTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationTypeModelToJson(this);
}

