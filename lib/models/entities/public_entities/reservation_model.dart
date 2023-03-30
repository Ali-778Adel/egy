import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reservation_model.g.dart';

@JsonSerializable()
class ReservationModel {

  @JsonKey(name: 'CityID')
  String? cityID;

  @JsonKey(name: 'BranchID')
  String? branchID;

  @JsonKey(name: 'ServiceTypeID')
  String? serviceTypeID;


  @JsonKey(name: 'DateTicket')
  String? dateTicket;

  @JsonKey(name: 'TimeTicket')
  String? timeTicket;



  @JsonKey(name: 'OrderRequestNo')
  String? orderRequestNo;




  @JsonKey(name: 'NatID')
  String? natID;



  @JsonKey(name: 'CustName')
  String? custName;




  @JsonKey(name: 'MobileNo')
  String? mobileNo;



  @JsonKey(name: 'TicketID')
  String? ticketID;



  @JsonKey(name: 'CityName')
  String? cityName;




  @JsonKey(name: 'BranchName')
  String? branchName;

  @JsonKey(name: 'ServiceTypeName')
  String? serviceTypeName;



  ReservationModel({
      this.branchName,
      this.orderRequestNo,
    this.mobileNo,
    this.custName,
    this.natID,
    this.serviceTypeID,
    this.branchID,
    this.ticketID,
    this.timeTicket,
    this.dateTicket,
    this.cityID,
    this.cityName,
    this.serviceTypeName,

  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}

