import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';

import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/repository/networks/appointment_network/appointment_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentCubitState> {
  AppointmentCubit(AppointmentCubitState initialState) : super(initialState);



  getBranchesList(int? cityId)async{

    emit(state.copyWith(isCitiesLoading : cityId == null , isBranchesLoading: cityId != null , cityBranches: [] , branchAvailableTimes: []));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getBranches(lang : lang.localeValue(),cityId : cityId ?? -1)
        .then((response) {
      logger.i('response : ${response.data?.toJson().toString()}');
      if(cityId == null) {
        emit(state.copyWith(isCitiesLoading : false , isBranchesLoading: false, allCities: response.data?.cities));
      } else {
        emit(state.copyWith(isCitiesLoading : false , isBranchesLoading: false, cityBranches: response.data?.branches));
      }

    }).onError((error, stackTrace) {

      emit(state.copyWith(isCitiesLoading : false , isBranchesLoading: false));
      logger.e(error);
    });



  }


  getServicesList(int? branchId)async{

    emit(state.copyWith(isServicesLoading : true , branchServices : []));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getServices(lang : lang.localeValue(),branchId : branchId ?? -1)
        .then((response) {


        emit(state.copyWith(isServicesLoading : false , branchServices: response.data));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isServicesLoading : false));
      logger.e(error);
    });



  }


  getAvailableTimes({int? branchId , String? date})async{

    print('request branch : $branchId , date : $date');
    emit(state.copyWith(isAvailableTimesLoading : true , availableTimeMessage : '' , branchAvailableTimes : []));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getAvailableTimes(lang : lang.localeValue(),branchId : branchId ?? -1 , dateTicket: date ?? '')
        .then((response) {

          print('response : ${response.message}');
      emit(state.copyWith(isAvailableTimesLoading : false , branchAvailableTimes: response.data , availableTimeMessage: response.message));


    }).onError((error, stackTrace) {
      emit(state.copyWith(isAvailableTimesLoading : false));
      logger.e(error);
    });



  }


  submitAppointment({
  required String natID,
  required String custName,
  required String mobileNo,
  required int branchID,
  required int serviceTypeID,
  required String dateTicket,
  required String timeTicket,
   String? orderRequestNo,
   String? ticketID
  })async{

    emit(state.copyWith(isSubmittingLoading : true));
    // await Future.delayed(const Duration(seconds: 3));
    // emit(state.copyWith(isSubmittingLoading : false));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.reserveTicket(
        lang : lang.localeValue(),
      natID: natID,
      custName: custName,
      mobileNo: mobileNo,
      branchID: branchID,
      serviceTypeID:  serviceTypeID,
      dateTicket: dateTicket,
      timeTicket: timeTicket,
      orderRequestNo: orderRequestNo ?? '0',
      ticketID: ticketID ?? '0'
    ).then((response) {

      print('response : ${response.message} ==> ticket id : ${response.data?.ticketID}');
      emit(state.copyWith(isSubmittingLoading : false
          , submittingFailMessage: response.success == false ? response.message : null
          , submittingSuccessMessage: response.success == true ? response.message : null
      ));



    }).onError((error, stackTrace) {
      emit(state.copyWith(isSubmittingLoading : false
          , submittingFailMessage: error.toString()
      ));
      logger.e(error);
    });



  }


  deleteAppointment({
    required String natID,
    required String custName,
    required String mobileNo,
    String? ticketID
  })async{

    emit(state.copyWith(isCancelLoading : true));
    // await Future.delayed(const Duration(seconds: 3));
    // emit(state.copyWith(isSubmittingLoading : false));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.deleteTicket(
        lang : lang.localeValue(),
        natID: natID,
        custName: custName,
        mobileNo: mobileNo,
        ticketID: ticketID ?? '0'
    ).then((response) {

      print('message : ${response.message} ==> data : ${response.data}');
      emit(state.copyWith(isCancelLoading : false
          , submittingFailMessage: response.success == false ? response.message : null
          , submittingSuccessMessage: response.success == true ? response.message : null
      ));



    }).onError((error, stackTrace) {
      emit(state.copyWith(isCancelLoading : false
          , submittingFailMessage: error.toString()
      ));
      logger.e(error);
    });



  }


  search({String? natId})async{

    emit(state.copyWith(isSearchLoading : true));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.inquiryReservation(lang : lang.localeValue(),natId: natId ?? '')
        .then((response) {

      print('response : ${response.message}');

      emit(state.copyWith(
          isSearchLoading : false ,
          reservationModel: response.data ,
          searchFailMessage: response.success == true? null : response.message
      ));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isSearchLoading : false));
      logger.e(error);
    });



  }




  Future<AppointmentClient> _getClient() async {
   Dio? dio = await AppPreference.instance.getRequestHeader();
   // dio = NetworkLogger().addInterceptors(dio);
    return AppointmentClient(dio);
  }



}
