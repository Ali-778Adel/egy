import 'package:json_annotation/json_annotation.dart';
part 'branch_available_time.g.dart';

@JsonSerializable()
class BranchAvailableTimeData {

  @JsonKey(name: 'TimeID')
  int? timeID;
  @JsonKey(name: 'ATime')
  String? aTime;


  BranchAvailableTimeData({
      this.timeID,
      this.aTime,});

  factory BranchAvailableTimeData.fromJson(Map<String, dynamic> json) =>
      _$BranchAvailableTimeDataFromJson(json);

  Map<String, dynamic> toJson() => _$BranchAvailableTimeDataToJson(this);
}

