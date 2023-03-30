// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      branchName: json['BranchName'] as String?,
      orderRequestNo: json['OrderRequestNo'] as String?,
      mobileNo: json['MobileNo'] as String?,
      custName: json['CustName'] as String?,
      natID: json['NatID'] as String?,
      serviceTypeID: json['ServiceTypeID'] as String?,
      branchID: json['BranchID'] as String?,
      ticketID: json['TicketID'] as String?,
      timeTicket: json['TimeTicket'] as String?,
      dateTicket: json['DateTicket'] as String?,
      cityID: json['CityID'] as String?,
      cityName: json['CityName'] as String?,
      serviceTypeName: json['ServiceTypeName'] as String?,
    );

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'CityID': instance.cityID,
      'BranchID': instance.branchID,
      'ServiceTypeID': instance.serviceTypeID,
      'DateTicket': instance.dateTicket,
      'TimeTicket': instance.timeTicket,
      'OrderRequestNo': instance.orderRequestNo,
      'NatID': instance.natID,
      'CustName': instance.custName,
      'MobileNo': instance.mobileNo,
      'TicketID': instance.ticketID,
      'CityName': instance.cityName,
      'BranchName': instance.branchName,
      'ServiceTypeName': instance.serviceTypeName,
    };
