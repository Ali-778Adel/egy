import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/data/remote_data_source/payment/payment_romte_data.dart';
import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_forms_resualt_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_service_type_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import '../../../data/local_data_source/payment/payment_local_data.dart';
import '../../../models/entities/payment_entities/folllow_order_model.dart';
import '../../../models/entities/payment_entities/payment_service_status_model.dart';

/// data controller to check if data from local or from server
class PaymentNetworkRepo {
  final PaymentRemoteData paymentRemoteData;
  final PaymentLocalData paymentLocalData;
  final AppPreference appPreference;

  PaymentNetworkRepo({
    required this.paymentRemoteData,
    required this.paymentLocalData,
    required this.appPreference,
  });

  /// get service types either from server or from cache
  Future<List<PaymentServiceTypeModel>> getServiceType() async {
    final local = await paymentLocalData.getCachedServiceType();
    return local.fold(
        (l) async => await paymentRemoteData.getServiceTypes(), (r) => r);
  }

  /// get service status either from server or from cache
  Future<List<PaymentServiceStatusModel>> getServiceStatus() async {
    final local = await paymentLocalData.getCachedServiceStatus();
    return local.fold(
        (l) async => await paymentRemoteData.getServiceStatus(), (r) => r);
  }

  /// get states list either from cache or drom server
  Future<List<PaymentStatesModel>> getStates() async {
    final local = await paymentLocalData.getCachedStates();
    return local.fold(
        (l) async => await paymentRemoteData.getStates(), (r) => r);
  }

  /// get list cities either from cache or from
  Future<List<PaymentCitiesModel>> getCities({required int stateId}) async {
    final local = await paymentLocalData.getCachedCities(stateId: stateId);
    return local.fold(
        (l) async => await paymentRemoteData.getCities(stateId: stateId),
        (r) => r);
  }

  Future<List<PaymentSubscriptionModel>> getSubscriptions(
      {required int serviceId}) async {
    final local =
        await paymentLocalData.getCachedSubscriptions(serviceId: serviceId);
    return local.fold(
        (l) async => paymentRemoteData.getSubscriptions(serviceId: serviceId),
        (r) => r);
  }

  /// register user data
  Future<PaymentFormsResultModel?> postUserData({required FormData body}) async {
    return await paymentRemoteData.postUserData(body: body);
  }

  /// get payment translators
  Future<List<PublicTranslatorEntity>> getPaymentTrans(
      {required int viewId}) async {
    final data = await paymentLocalData.getPaymentViewTrans(viewId: viewId);
    return data.fold(
        (l) async => await paymentRemoteData.getViewTrans(viewId: viewId),
        (r) => r);
  }

  Future<List<PublicTranslatorEntity>> getPaymentUpdatedTrans(
      {required int viewId}) async {
    try {
      final data =
          await paymentRemoteData.getPaymentViewUpdates(viewId: viewId);
      if (data.isEmpty) {
        return getPaymentTrans(viewId: viewId);
      } else {
        return await paymentRemoteData.getViewTrans(viewId: viewId);
      }
    } catch (e) {
      return getPaymentTrans(viewId: viewId);
    }
  }



  Future<List<FollowOrderModel>>followPaymentOrders()async{
    return await paymentRemoteData.followPaymentOrder();
  }

  Future<dynamic> updateUserData({required FormData body})async{
    return await paymentRemoteData.updateUserData(body: body);
  }

  Future<int?>postPaymentResponse({required Map<String,dynamic>json}){
    return paymentRemoteData.postPaymentResponse(json: json);
  }
}
