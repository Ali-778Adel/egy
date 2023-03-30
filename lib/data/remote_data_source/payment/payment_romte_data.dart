import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/data/local_data_source/payment/payment_local_data.dart';
import 'package:fl_egypt_trust/data/services/dio/dio_client.dart';
import 'package:fl_egypt_trust/data/services/dio/list_api.dart';
import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_forms_resualt_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_service_status_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_service_type_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../di/dependency_injection.dart';
import '../../../models/entities/payment_entities/folllow_order_model.dart';
import '../../../models/entities/payment_entities/payment_register_user_data.dart';
import '../../../models/utils/app_preference.dart';

abstract class PaymentRemoteData {
  Future<List<PaymentServiceTypeModel>> getServiceTypes();
  Future<List<PaymentServiceStatusModel>> getServiceStatus();

  Future<List<PaymentCitiesModel>> getCities({required int stateId});
  Future<List<PaymentStatesModel>> getStates();

  Future<List<PaymentSubscriptionModel>>getSubscriptions({required int serviceId});

  Future<List<PublicTranslatorEntity>>getViewTrans({required int viewId});
  Future<PaymentFormsResultModel>postUserData({required FormData body});

  Future<List<PublicTranslatorEntity>> getPaymentViewUpdates({required int viewId});

  Future<List<FollowOrderModel>>followPaymentOrder();

  Future<dynamic> updateUserData({required FormData body});

  Future<int?>postPaymentResponse({required Map<String,dynamic>json});
}

class PaymentRemoteDataImpl implements PaymentRemoteData {
  @override
  Future<List<PaymentServiceStatusModel>> getServiceStatus() async {
    final response =
        await sl<DioClientService>().getRequest(ListApi.serviceStatus);
    final List objects = response.data;
    final responseToModel =
        objects.map((e) => PaymentServiceStatusModel.fromJson(e)).toList();
    await sl<PaymentLocalData>()
        .setCachedServiceStatus(models: responseToModel);
    return Future.value(responseToModel);
  }

  @override
  Future<List<PaymentServiceTypeModel>> getServiceTypes() async {
    final response =
        await sl<DioClientService>().getRequest(ListApi.serviceTypes);
    final List objects = response.data;
    final responseToModel =
        objects.map((e) => PaymentServiceTypeModel.fromJson(e)).toList();
    await sl<PaymentLocalData>().setCachedServiceType(models: responseToModel);
    return Future.value(responseToModel);
  }

  @override
  Future<List<PaymentCitiesModel>> getCities({required int stateId}) async {
    final response = await sl<DioClientService>().getRequest('${ListApi.cities}/$stateId');
    final List objects = response.data;
    final responseToModel =
        objects.map((e) => PaymentCitiesModel.fromJson(e)).toList();
    await sl<PaymentLocalData>().setCachedCities(models: responseToModel, stateId: stateId);
    return Future.value(responseToModel);
  }

  @override
  Future<List<PaymentStatesModel>> getStates() async {
    final response = await sl<DioClientService>().getRequest(ListApi.states);
    final List objects = response.data;
    final responseToModel =
        objects.map((e) => PaymentStatesModel.fromJson(e)).toList();
    await sl<PaymentLocalData>().setCachedStates(models: responseToModel);
    return responseToModel;
  }

  @override
  Future<List<PaymentSubscriptionModel>> getSubscriptions({required int serviceId})async {
    final response=await sl<DioClientService>().getRequest('${ListApi.subscriptions}/$serviceId');
    final List objects=response.data;
    final responseTomModel=objects.map((e) => PaymentSubscriptionModel.fromJson(json: e)).toList();

    await sl<PaymentLocalData>().setCachedSubscriptions(models: responseTomModel, serviceId: serviceId);
    return responseTomModel;

  }

  @override
  Future<PaymentFormsResultModel> postUserData({required FormData body}) async{
 try{
   final response= await sl<DioClientService>().postForms(url:'EgyptTrustUsers',data: body);
   final json=response.data;
   debugPrint('json is $json');
   final jsonToObject=PaymentFormsResultModel.fromJson(json);
   await sl<PaymentLocalData>().setPaymentApplicationResponse(paymentFormsResultModel: jsonToObject);
   return jsonToObject;
 }catch(e,s){
   throw(Exception('$e$s'));
 }
  }

  @override
  Future<dynamic> updateUserData({required FormData body}) async{
    try{
      final response= await sl<DioClientService>().updateClientData(url:ListApi.updateUserData,formData: body);
      final json=response.data;
      print(json);
      return json;
      // debugPrint('json is $json');
      // final jsonToObject=PaymentFormsResultModel.fromJson(json);
      // await sl<PaymentLocalData>().setPaymentApplicationResponse(paymentFormsResultModel: jsonToObject);
      // return jsonToObject;
    }catch(e,s){
      throw(Exception('$e$s'));
    }
  }

  @override
  Future<List<PublicTranslatorEntity>> getViewTrans({required int viewId})async{
    final response=await sl<DioClientService>().getRequest('${ListApi.viewTranslators}$viewId');
    final List objects=response.data;
    final objectsToModels=objects.map((e) => PublicTranslatorEntity.fromJson(json: e)).toList();
    if(objects.isNotEmpty)await sl<PaymentLocalData>().setPaymentViewTrans(models: objectsToModels, viewId: viewId);

    return objectsToModels;

  }


  @override
  Future<List<PublicTranslatorEntity>> getPaymentViewUpdates({required int viewId})async {
    final response=await sl<DioClientService>().getRequest('${ListApi.viewTransUpdates}$viewId');
    final List objects=response.data;
    final objectsToModel=objects.map<PublicTranslatorEntity>((e) =>PublicTranslatorEntity.fromJson(json: e)).toList();
    return objectsToModel;
  }

  @override
  Future<List<FollowOrderModel>>followPaymentOrder()async {
    // final token1='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQ0xJXzEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjIyOGIxMDg2LWRkOTgtNDZkZi04ZTU3LTY1Mzg1YjAwMTM2NSIsImp0aSI6ImU2ZGFkNTE1LWZhMTYtNDdmYy04OTUyLTIwZDdhMjlmODBmNSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlItOTk5IiwiZXhwIjoxOTk0MDU0NTA4LCJpc3MiOiJlZ3lwdHRydXN0LmNvbSIsImF1ZCI6ImF1ZGllbmNlIn0.coxDeGUJSUUjX1Js78y5jhddOPWZmEQ2a4EL0Mdui2g';
    final String? token =await sl<AppPreference>().getUserPaymentToken();
    final response=await sl<DioClientService>().getRequest(ListApi.followOrders,
        token:token);
    final List objects=response.data;
    final objectToModel=objects.map((e) => FollowOrderModel.fromJson(json: e)).toList();
    return objectToModel;
  }

  @override
  Future<int?> postPaymentResponse({required Map<String, dynamic> json})async {
    final String? token =await sl<AppPreference>().getUserPaymentToken();
     print('token for payment response is $token ');
    final respone=await sl<DioClientService>().postRequest(ListApi.sendPaymentResponse,
        data: json,token: token);
  print(respone.data);
  return respone.statusCode;
  }
}
