import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/repository/networks/auth/auth_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(AuthCubitState initialState) : super(initialState);







  logout(){
    emit(state.copyWith( userData: null));
    AppPreference.instance.setUserData(null);
  }
  login({required String userName , required String password})async{

    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.login(lang : lang.localeValue(),userName : userName, password: password)
        .then((response) {
      logger.e('login => ${response.toJson((value) => value.toJson())}');
      if(response.success == true) {
        // logger.e('login => ${response.data?.toJson()}');
        emit(state.copyWith(isLoginLoading: false, userData: response.data , loginSuccessMessage: response.message));
        AppPreference.instance.setUserData(response.data);
        AppPreference.instance.setLoginData(userName: userName, password: password);
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }


  changePassword({required String userName , required String currentPassword, required String newPassword})async{

    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.changePassword(lang : lang.localeValue(),userName : userName,oldPassword: currentPassword , newPassword: newPassword)
        .then((response) {

      if(response.success == true) {
        logger.e('login => ${response.data?.toJson()}');
        emit(state.copyWith(isLoginLoading: false, userData: response.data , loginSuccessMessage: response.message));
        AppPreference.instance.setLoginData(userName: userName, password: newPassword);
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }

  checkSession()async{

    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.checkSession(lang : lang.localeValue())
        .then((response) async{

      print('response : ${response.data} , message : ${response.message}');
      emit(state.copyWith(isLoginLoading : false ));
      if(response.success != true) {
        AppPreference.instance.setUserData(null);
      }else{
        emit(state.copyWith(userData : await AppPreference.instance.getUserData()));
      }


    }).onError((error, stackTrace) {
      AppPreference.instance.setUserData(null);
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }

  requestActivateToken({required String mobile})async{

    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.requestActivateToken(lang : lang.localeValue(),mobileNo : mobile)
        .then((response) {
      logger.e('request activate token => ${response.message}');
      if(response.success == true) {
        emit(state.copyWith(isLoginLoading: false,  loginSuccessMessage: response.message));
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }

  activateToken({required String mobile, required String otp ,required String password})async{
    logger.e('activateToken => mobile : $mobile , otp : $otp , password : $password');
    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.activateToken(
        lang : lang.localeValue(),
        mobileNo : mobile,
      otpPwd: otp,
      newPwd: password,
    )
        .then((response) {
      logger.e('request activate token => ${response.data}');
      if(response.success == true) {
        emit(state.copyWith(isLoginLoading: false,  loginSuccessMessage: response.message));
        AppPreference.instance.setLoginData(userName: mobile, password: password);
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }



  requestResetPassword({required String mobile})async{

    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.forgotPassword(lang : lang.localeValue(),userName : mobile)
        .then((response) {
      logger.e('request activate token => ${response.message}');
      if(response.success == true) {
        emit(state.copyWith(isLoginLoading: false,  loginSuccessMessage: response.message));
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }



  confirmResetPassword({required String mobile, required String otp ,required String password})async{
    logger.e('activateToken => mobile : $mobile , otp : $otp , password : $password');
    emit(state.copyWith(isLoginLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    await client.confirmForgotPassword(
      lang : lang.localeValue(),
      userName : mobile,
      otpCode: otp,
      newPassword: password,
    )
        .then((response) {
      logger.e('request activate token => ${response.data}');
      if(response.success == true) {
        emit(state.copyWith(isLoginLoading: false,  loginSuccessMessage: response.message));
        AppPreference.instance.setLoginData(userName: mobile, password: password);
      }else{
        emit(state.copyWith(isLoginLoading: false, loginErrorMessage: response.message));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoginLoading : false));
      logger.e(error);
    });

  }




  Future<AuthClient> _getClient() async {
   Dio? dio = await AppPreference.instance.getRequestHeader();
   logger.e('headers => ${dio.options.headers}');
   // dio = NetworkLogger().addInterceptors(dio);
    return AuthClient(dio);
  }


}


class SystemCubit extends Cubit<SystemCubitState> {
  SystemCubit(SystemCubitState initialState) : super(initialState);





  systemOptions({String? iosVersion , String? androidVersion})async{

    emit(state.copyWith(isLoading : true));
    final client = await _getClient();

    EnumLanguage lang = await AppPreference.instance.getLocale();

    logger.e('request system options => iosVersion : $iosVersion , androidVersion : $androidVersion');
    await client.systemOptions(lang : lang.localeValue(),iosVersion : iosVersion , androidVersion: androidVersion)
        .then((response) {
      logger.e('response system options => ${response.toJson((value) => {})}');
      if(response.success == true) {
        String? updateMessage;
        bool? isForceUpdate;
        if(response.optionalUpdateMsg != null && response.optionalUpdateMsg?.isNotEmpty == true){
          isForceUpdate = false;
          updateMessage = response.optionalUpdateMsg ;
        }else if(response.forceUpdateMsg != null && response.forceUpdateMsg?.isNotEmpty == true){
          isForceUpdate = true;
          updateMessage = response.forceUpdateMsg;
        }
        emit(state.copyWith(
            isLoading: false,
            showUpdate: updateMessage != null,
          updateMessage: updateMessage,
          isForceUpdate: isForceUpdate
        ));
      }else{
        emit(state.copyWith(isLoading: false));
      }


    }).onError((error, stackTrace) {
      emit(state.copyWith(isLoading : false));
      logger.e(error);
    });

  }



  Future<AuthClient> _getClient() async {
    Dio? dio = await AppPreference.instance.getRequestHeader();
    logger.e('headers => ${dio.options.headers}');
    // dio = NetworkLogger().addInterceptors(dio);
    return AuthClient(dio);
  }
}