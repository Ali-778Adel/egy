
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:fl_egypt_trust/models/entities/branches/branches_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_forms_resualt_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_service_status_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_service_type_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';
import 'package:fl_egypt_trust/models/entities/public_entities/user_model.dart';
import 'package:fl_egypt_trust/models/entities/theme_enities/colors_entity.dart';
import 'package:fl_egypt_trust/models/entities/theme_enities/icons_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../entities/home_entities/home_translator_entity.dart';
import '../entities/payment_auth/payment_auth_model.dart';
import '../entities/payment_entities/payment_cities_model.dart';
import 'language/languages.dart';
import 'package:dio/dio.dart';


const String _keyLOCALE = 'KEY_LOCALE';
const String _keyTHEME = 'KEY_THEME';
const String _userData = 'user_data';
const String _loginUserName = 'login_user_name';

const String _loginPassword = 'login_password';

/// just for seal and signature services
const String _keyCheckUserToken='key_check_user_token';

const String _hiveBoxKey = 'gate_box';

const String keyPaymentBox='payment_box';


class AppPreference {
  static final AppPreference instance = AppPreference._internal();
  Box? box;
  Box? paymentBox;
  bool isNetworkAvailable = true;

  factory AppPreference() {
    return instance;
  }

  AppPreference._internal() {
    initPref();
    registerServiceStatus();
  }

  initPref() async {
    box = await Hive.openBox(_hiveBoxKey);
    paymentBox=await Hive.openBox(keyPaymentBox);

  }

  Future<Box?> _getBox() async {
    if (box == null ) await initPref();
    return box;
  }

  Future<Box?>getPaymentBox()async{
    if(paymentBox ==null)await initPref();
    return paymentBox;
  }

  setUserData(UserData? userData)async {
    (await _getBox())?.put(_userData, userData == null ? null : jsonEncode(userData.toJson()));
  }

  Future<UserData?> getUserData() async {
    String? data =(await _getBox())?.get(_userData);

    if(data == null || jsonDecode(data) == null) return null;
    return UserData.fromJson(jsonDecode(data));
  }
   /// caching user payment token
  /// used for follow user orders (just payment operation)
  setUserPaymentToken({required String userPaymentToken})async{
    (await _getBox())!.put(_keyCheckUserToken, userPaymentToken);
  }

  Future<String?>getUserPaymentToken()async{
    String ?token=(await _getBox())!.get(_keyCheckUserToken);
    if(token != null){
      return token;
    }
    else{
      return null;
    }
  }

  setPaymentOrderRefNumber({required String merchantNumber,required String orderRefNumber})async{
    try{
      (await _getBox())!.put(merchantNumber, orderRefNumber);
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm $merchantNumber');
      print('oooooooooooooooooooooooooooooooo $orderRefNumber');
    }catch(e){
      print('error on setPAYMENToRDER $e');
    }

}

getPaymentOrderRefNumber({required String merchantNumber})async{
    String?orderRefNumber=(await _getBox())!.get(merchantNumber);
    if(orderRefNumber !=null){
      return orderRefNumber;
    }else{
      return null;
    }
}

  setLoginData({required String userName , required String password})async {
    (await _getBox())?.put(_loginUserName, userName);
    (await _getBox())?.put(_loginPassword, password);
  }

  Future<MapEntry<String, String>?> getLoginData() async {
    var box =await _getBox();
    String? userName = box?.get(_loginUserName);
    String? password = box?.get(_loginPassword);
    if(userName == null || password == null) return null;
    return MapEntry( userName, password);
  }







  Future<EnumLanguage> getLocale() async {
    var box =await _getBox();
    print('Preferences locale : ${box?.get(_keyLOCALE)}');
    return EnumToString.fromString(
            EnumLanguage.values, box?.get(_keyLOCALE) ?? '') ??
        EnumLanguage.arabic;
  }


  setLocale(EnumLanguage language) async {

    print('network set locale : ${language.localeValue()}');
    (await _getBox())?.put(_keyLOCALE, EnumToString.convertToString(language));
  }

  Future<EnumNetworkLangs> getNetworkLocale() async {
    var box =await _getBox();
    print('network locale : ${box?.get('keyNetworkLocale')}');
    return EnumToString.fromString(
        EnumNetworkLangs.values, box?.get('keyNetworkLocale') ?? '') ??
        EnumNetworkLangs.arabic;
  }

  setNetworkLocale(EnumNetworkLangs langs)async{
    (await _getBox())?.put('keyNetworkLocale', EnumToString.convertToString(langs));
  }

  setTheme(ThemeMode themeMode) async {
    (await _getBox())?.put(_keyTHEME, themeMode);
  }

  Future<Dio> getRequestHeader()async {
    UserData? user = await getUserData();
    return Dio(BaseOptions(
        // contentType: "application/json",
        headers: user == null || user.accessToken?.isEmpty == true ? {'HDR_FLG' : 1} : {'Authorization': 'Bearer ${user.accessToken}' , 'HDR_FLG' : 1})
    );
  }


  void registerServiceStatus(){

   /// REGISTER_PAYMENT-ADAPTERS
   Hive.registerAdapter(PaymentServiceStatusModelAdapter());
   Hive.registerAdapter(PaymentServiceTypeModelAdapter());
   Hive.registerAdapter(PaymentStatesModelAdapter());
   Hive.registerAdapter(PaymentCitiesModelAdapter());
   Hive.registerAdapter(PaymentSubscriptionModelAdapter());
   Hive.registerAdapter(PaymentFormsResultModelAdapter());
   Hive.registerAdapter(PaymentAuthModelAdapter());
   Hive.registerAdapter(BranchesModelAdapter());


   /// REGISTER_HOME_ADAPTERS
   Hive.registerAdapter(PublicTranslatorEntityAdapter());
   /// REGISTER/THEME_ADAPTERS
   Hive.registerAdapter(ColorsEntityAdapter());
   Hive.registerAdapter(IconsEntityAdapter());
  }

}
