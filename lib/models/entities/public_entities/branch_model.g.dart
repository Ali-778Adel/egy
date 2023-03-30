// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchData _$BranchDataFromJson(Map<String, dynamic> json) => BranchData(
      phoneNumber: json['PhoneNumber'] as String?,
      branchName: json['BranchName'] as String?,
      managerName: json['ManagerName'] as String?,
      address: json['Address'] as String?,
      imageUrl: json['ImageUrl'] as String?,
      branchID: json['BranchID'] as int?,
      lat: json['Lat'] as String?,
      lon: json['Lon'] as String?,
      mapRef: json['MapRef'] as String?,
    );

Map<String, dynamic> _$BranchDataToJson(BranchData instance) =>
    <String, dynamic>{
      'PhoneNumber': instance.phoneNumber,
      'BranchName': instance.branchName,
      'ManagerName': instance.managerName,
      'Address': instance.address,
      'MapRef': instance.mapRef,
      'BranchID': instance.branchID,
      'ImageUrl': instance.imageUrl,
      'Lat': instance.lat,
      'Lon': instance.lon,
    };
