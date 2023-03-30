// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchListModel _$BranchListModelFromJson(Map<String, dynamic> json) =>
    BranchListModel(
      branches: (json['Branches'] as List<dynamic>?)
          ?.map((e) => BranchData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cities: (json['Cities'] as List<dynamic>?)
          ?.map((e) => CityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchListModelToJson(BranchListModel instance) =>
    <String, dynamic>{
      'Cities': instance.cities,
      'Branches': instance.branches,
    };
