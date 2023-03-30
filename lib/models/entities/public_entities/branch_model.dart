import 'package:json_annotation/json_annotation.dart';
part 'branch_model.g.dart';

@JsonSerializable()
class BranchData {


  @JsonKey(name: 'PhoneNumber')
  String? phoneNumber;

  @JsonKey(name: 'BranchName')
  String? branchName;

  @JsonKey(name: 'ManagerName')
  String? managerName;

  @JsonKey(name: 'Address')
  String? address;

  @JsonKey(name: 'MapRef')
  String? mapRef;

  @JsonKey(name: 'BranchID')
  int? branchID;

  @JsonKey(name: 'ImageUrl')
  String? imageUrl;

  @JsonKey(name: 'Lat')
  String? lat;

  @JsonKey(name: 'Lon')
  String? lon;




  BranchData({
      this.phoneNumber,
    this.branchName,
    this.managerName,
    this.address,
    this.imageUrl,
    this.branchID,
    this.lat,
    this.lon,
    this.mapRef,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) =>
      _$BranchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDataToJson(this);
}

