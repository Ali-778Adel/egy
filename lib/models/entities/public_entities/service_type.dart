import 'package:json_annotation/json_annotation.dart';
part 'service_type.g.dart';

@JsonSerializable()
class ServiceTypeData {

  @JsonKey(name: 'ServiceTypeID')
  int? serviceTypeID;
  @JsonKey(name: 'ServiceTypeName')
  String? serviceTypeName;


  ServiceTypeData({
      this.serviceTypeID,
      this.serviceTypeName,});

  factory ServiceTypeData.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceTypeDataToJson(this);
}

