import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';
import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/repository/networks/certification_network/certification_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/public_entities/create_certification_model.dart';

class CertificationCubit extends Cubit<CertificationCubitState> {
  CertificationCubit(CertificationCubitState initialState) : super(initialState);




  getCertificationsList()async{

    emit(state.copyWith(isServicesLoading : true , certificationsTypes : []));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getCertificationTypes(lang : lang.localeValue())
        .then((response) {


        emit(state.copyWith(isServicesLoading : false , certificationsTypes: response.data));


    }).onError((error, stackTrace) {
      logger.e(error);
    });



  }



  getActiveCertifications()async{

    emit(state.copyWith(isUserCertificationsLoading : true , userCertifications: null));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getActiveCertifications(lang : lang.localeValue())
        .then((response) {
          if(response.success == true) {
            emit(state.copyWith(
                isUserCertificationsLoading: false, userCertifications: response.data));
          }else{
            emit(state.copyWith(isUserCertificationsLoading : false , userCertifications: null , userCertificationsErrorMessage: response.message));
          }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isUserCertificationsLoading : false , userCertifications: null , userCertificationsErrorMessage: error.toString()));
      logger.e(error);
    });



  }




  submit({
  required String natID,
  required String custName,
  required String mobileNo,
  required int certificationType,
  required List<DocumentModel> documents,
   String? orderRequestNo,
  })async{


    print('natID : $natID ==> custName : $custName ==> mobileNo : $mobileNo ==> certificationType : $certificationType ==> orderRequestNo : $orderRequestNo');


    emit(state.copyWith(isSubmittingLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();
    var body = CreateCertificationModel(
      lang: lang.localeValue(),
      orderRequestNo: orderRequestNo ?? '0',
      mobileNo: mobileNo,
      custName: custName,
      certificateTypeID: certificationType,
      natid: natID,
      oRDDocuments: documents
    );
    await client.reserveOrder(body : body)
        .then((response) {

      print('response : ${response.message} ==> ticket id : ${response.data}');

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


  search({String? natId})async{

    emit(state.copyWith(isSearchLoading : true));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.inquiryOrder(lang : lang.localeValue(),natId: natId ?? '')
        .then((response) {

      print('response : ${response.message}');

      emit(state.copyWith(
          isSearchLoading : false ,
          orderModel: response.data ,
          searchFailMessage: response.success == true? null : response.message
      ));


    }).onError((error, stackTrace) {

      emit(state.copyWith(isSearchLoading : false));
      logger.e(error);
    });



  }


  Future<CertificationClient> _getClient() async {
   Dio? dio = await AppPreference.instance.getRequestHeader();
   // dio = NetworkLogger().addInterceptors(dio);
    return CertificationClient(dio);
  }


}
