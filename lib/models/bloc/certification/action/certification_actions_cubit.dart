import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit_state.dart';

import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/repository/networks/certification_network/certification_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificationActionsCubit extends Cubit<CertificationActionsCubitState> {
  CertificationActionsCubit(CertificationActionsCubitState initialState) : super(initialState);







  requestCertificationPin({String? certificationSerial})async{
    
    emit(state.copyWith(isActionLoading : true,certificationPinModel: null));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.sendCertificationOtp(lang : lang.localeValue(),certificationSerial: certificationSerial ?? '')
        .then((response) {

      print('response : ${response.message}');

      emit(state.copyWith(isActionLoading : false,
          certificationPinModel: response.data,
        actionSuccessMessage: response.success == false ? null : response.message,
        actionFailMessage: response.success == true ? null : response.message
      ));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isActionLoading : false,certificationPinModel: null));
      logger.e(error);
    });



  }


  requestRevokeCertificationPin({String? certificationSerial})async{

    emit(state.copyWith(isActionLoading : true,certificationPinModel: null));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.sendRevokeCertificationOtp(lang : lang.localeValue(),certificationSerial: certificationSerial ?? '')
        .then((response) {

      print('response : ${response.message}');

      emit(state.copyWith(isActionLoading : false,
          actionSuccessMessage: response.success == false ? null : response.message,
          actionFailMessage: response.success == true ? null : response.message
      ));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isActionLoading : false));
      logger.e(error);
    });



  }


  revokeCertification({String? certificationSerial , String? otp})async{

    emit(state.copyWith(isRevokeActionLoading : true,certificationPinModel: null));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.revokeCertification(lang : lang.localeValue(),certificationSerial: certificationSerial ?? '' , otp: otp ?? '')
        .then((response) {

      print('response : ${response.message}');

      emit(state.copyWith(isRevokeActionLoading : false,
          actionSuccessMessage: response.success == false ? null : response.message,
          actionFailMessage: response.success == true ? null : response.message
      ));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isRevokeActionLoading : false));
      logger.e(error);
    });



  }



  Future<CertificationClient> _getClient() async {
   Dio? dio = await AppPreference.instance.getRequestHeader();
   // dio = NetworkLogger().addInterceptors(dio);
    return CertificationClient(dio);
  }


}
