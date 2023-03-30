import 'package:json_annotation/json_annotation.dart';
part 'certification_pin_model.g.dart';

@JsonSerializable()
class CertificationPinModel {

  @JsonKey(name: 'Password')
  String? password;


  CertificationPinModel({
      this.password,});

  factory CertificationPinModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationPinModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationPinModelToJson(this);
}

