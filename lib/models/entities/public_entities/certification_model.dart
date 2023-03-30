import 'package:json_annotation/json_annotation.dart';
part 'certification_model.g.dart';

@JsonSerializable()
class CertificationData {

  @JsonKey(name: 'CertSerial')
  String? certSerial;
  @JsonKey(name: 'RestOfData')
  List<RestOfData>? restOfData;

  CertificationData({
      this.certSerial,
      this.restOfData,});

  factory CertificationData.fromJson(Map<String, dynamic> json) =>
      _$CertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationDataToJson(this);
}


@JsonSerializable()
class RestOfData{
  @JsonKey(name: 'Key')
  String? key;
  @JsonKey(name: 'Value')
  String? value;

  RestOfData({this.key, this.value});
  factory RestOfData.fromJson(Map<String, dynamic> json) =>
      _$RestOfDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestOfDataToJson(this);

}
