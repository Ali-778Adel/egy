
import 'package:json_annotation/json_annotation.dart';
import 'branch_model.dart';
import 'city_model.dart';
part 'branch_list_model.g.dart';

@JsonSerializable()
class BranchListModel {

  @JsonKey(name: 'Cities')
  List<CityData>? cities;

  @JsonKey(name: 'Branches')
  List<BranchData>? branches;


  BranchListModel({
      this.branches,
      this.cities,});

  factory BranchListModel.fromJson(Map<String, dynamic> json) =>
      _$BranchListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListModelToJson(this);
}

