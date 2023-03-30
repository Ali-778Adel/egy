import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/repository/networks/api_response.dart';
import 'package:fl_egypt_trust/repository/networks/network_constants.dart';
import 'package:retrofit/http.dart';

import '../../../models/entities/public_entities/branch_available_time.dart';
import '../../../models/entities/public_entities/branch_list_model.dart';
import '../../../models/entities/public_entities/reservation_model.dart';
import '../../../models/entities/public_entities/service_type.dart';
import '../../../models/entities/public_entities/ticket_response_data.dart';

part 'appointment_network.g.dart';

@RestApi(baseUrl: NetworkConstants.baseUrl)
abstract class AppointmentClient {
  factory AppointmentClient(Dio dio, {String baseUrl}) = _AppointmentClient;

  @FormUrlEncoded()
  @POST(NetworkConstants.methodListBranches)
  Future<ApiResponse<BranchListModel>> getBranches({
    @Field('Lang') required String lang,
    @Field('CityID') required int? cityId
  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodListServiceType)
  Future<ApiResponse<List<ServiceTypeData>>> getServices({ @Field('Lang') required String lang,@Field('BranchID') required int branchId});


  @FormUrlEncoded()
  @POST(NetworkConstants.methodListAvailableTimes)
  Future<ApiResponse<List<BranchAvailableTimeData>>> getAvailableTimes({
    @Field('Lang') required String lang,
    @Field('BranchID') required int branchId,
    @Field('DateTicket') required String dateTicket,
  });



  @FormUrlEncoded()
  @POST(NetworkConstants.methodReserveTicket)
  Future<ApiResponse<TicketResponseData>> reserveTicket({
    @Field("Lang") required String lang,
        @Field("NatID") required String natID,
        @Field("CustName") required String custName,
        @Field("MobileNo") required String mobileNo,
        @Field("BranchID") required int branchID,
        @Field("ServiceTypeID") required int serviceTypeID,
        @Field("DateTicket") required String dateTicket,
        @Field("TimeTicket") required String timeTicket,
        @Field("OrderRequestNo") required String orderRequestNo,
        @Field("TicketID") required String ticketID

      });



  @FormUrlEncoded()
  @POST(NetworkConstants.methodReserveTicket)
  Future<ApiResponse<dynamic>> deleteTicket({
    @Field("Lang") required String lang,
    @Field("NatID") required String natID,
    @Field("CustName") required String custName,
    @Field("MobileNo") required String mobileNo,
    @Field("DeleteReserve") int delete = 1,
    @Field("TicketID") required String ticketID

  });


  @FormUrlEncoded()
  @POST(NetworkConstants.methodInquiryReservation)
  Future<ApiResponse<ReservationModel>> inquiryReservation({
    @Field('Lang') required String lang,
    @Field('NatID') required String natId,
  });



}
