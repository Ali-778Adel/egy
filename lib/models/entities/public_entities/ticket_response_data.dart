import 'package:json_annotation/json_annotation.dart';
part 'ticket_response_data.g.dart';

@JsonSerializable()
class TicketResponseData {

  @JsonKey(name: 'TicketID')
  String? ticketID;


  TicketResponseData({
      this.ticketID,});

  factory TicketResponseData.fromJson(Map<String, dynamic> json) =>
      _$TicketResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TicketResponseDataToJson(this);
}

