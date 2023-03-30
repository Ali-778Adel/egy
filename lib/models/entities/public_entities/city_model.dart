import 'package:json_annotation/json_annotation.dart';
part 'city_model.g.dart';

@JsonSerializable()
class CityData {

  @JsonKey(name: 'CityName')
  String? cityName;
  @JsonKey(name: 'CityID')
  String? cityID;


  CityData({
      this.cityName,
      this.cityID,});

  factory CityData.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromJson(json);

  Map<String, dynamic> toJson() => _$CityDataToJson(this);
}

