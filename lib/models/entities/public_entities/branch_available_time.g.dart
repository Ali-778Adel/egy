// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_available_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAvailableTimeData _$BranchAvailableTimeDataFromJson(
        Map<String, dynamic> json) =>
    BranchAvailableTimeData(
      timeID: json['TimeID'] as int?,
      aTime: json['ATime'] as String?,
    );

Map<String, dynamic> _$BranchAvailableTimeDataToJson(
        BranchAvailableTimeData instance) =>
    <String, dynamic>{
      'TimeID': instance.timeID,
      'ATime': instance.aTime,
    };
