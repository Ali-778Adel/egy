import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_forms_resualt_model.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../di/dependency_injection.dart';
import '../../../models/entities/payment_entities/payment_service_status_model.dart';
import '../../../models/entities/payment_entities/payment_service_type_model.dart';
import '../../../models/entities/payment_entities/payment_subscription_model.dart';
import '../../../models/entities/payment_entities/paymnet_states_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentLocalData {
  Future<void> setCachedServiceStatus(
      {required List<PaymentServiceStatusModel> models});
  Future<Either<bool ,List<PaymentServiceStatusModel>>> getCachedServiceStatus();

  Future<void> setCachedServiceType(
      {required List<PaymentServiceTypeModel> models});
  Future<Either<bool, List<PaymentServiceTypeModel>>> getCachedServiceType();

  Future<void> setCachedStates({required List<PaymentStatesModel> models});
  Future<Either<bool,List<PaymentStatesModel>>> getCachedStates();

  Future<void> setCachedCities({required List<PaymentCitiesModel> models,required int stateId});
  Future<Either<bool,List<PaymentCitiesModel>>> getCachedCities({required int stateId});

  Future<void>setCachedSubscriptions({required List<PaymentSubscriptionModel>models,required int serviceId});
  Future<Either<bool,List<PaymentSubscriptionModel>>> getCachedSubscriptions({required int serviceId});


  Future<void>setPaymentViewTrans({required List<PublicTranslatorEntity>models,required int viewId});
  Future<Either<bool,List<PublicTranslatorEntity>>>getPaymentViewTrans({required int viewId});

  Future<void>setPaymentApplicationResponse({required PaymentFormsResultModel paymentFormsResultModel});
  Future<Either<bool,PaymentFormsResultModel>>getPaymentApplicationResponse();

}

class PaymentLocalDataImpl implements PaymentLocalData {
  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<void> setCachedServiceStatus(
      {required List<PaymentServiceStatusModel> models}) async {
    try {
      (await box())!.put('keyServiceStatus', models);
      debugPrint('data cached successfully');
    } catch (e) {
      debugPrint('error in caching $e');
    }
  }

  @override
  Future<Either<bool ,List<PaymentServiceStatusModel>>> getCachedServiceStatus() async {
    try {
      if((await box())!.containsKey('keyServiceStatus')){
        final data = (await box())!.get('keyServiceStatus') as List<dynamic>;
        final List<PaymentServiceStatusModel> paymentServiceStatusModel = data
            .map((e) => PaymentServiceStatusModel(
            serviceId: e.serviceId, serviceName: e.serviceName))
            .toList()
            .cast<PaymentServiceStatusModel>();
        debugPrint(paymentServiceStatusModel[0].serviceName);
        return right(paymentServiceStatusModel);
      }else{
        return left(false);
      }

    } catch (e) {
      debugPrint('error in get cache $e');
      throw ('$e');
    }
  }

  @override
  Future<void> setCachedServiceType(
      {required List<PaymentServiceTypeModel> models}) async {
    try {
      (await box())!.put('keyServiceType', models);
      debugPrint('types cached successfully');
    } catch (e) {
      debugPrint('error in set serviceTypes $e');
    }
  }

  @override
  Future<Either<bool, List<PaymentServiceTypeModel>>>
      getCachedServiceType() async {
    try {
      if ((await box())!.containsKey('keyServiceType')) {
        final data = (await box())?.get('keyServiceType') as List<dynamic>;
        final List<PaymentServiceTypeModel> paymentServiceTypeModel = data
            .map((e) => PaymentServiceTypeModel(
                serviceId: e.serviceId, serviceName: e.serviceName))
            .toList()
            .cast<PaymentServiceTypeModel>();
        return right(paymentServiceTypeModel);
      } else {
        return left(false);
      }
    } catch (e) {
      debugPrint('error in get serviceType $e');
      throw ('$e');
    }
  }

  @override
  Future<void> setCachedStates(
      {required List<PaymentStatesModel> models}) async {
    (await box())!.put('keyStates', models);
  }

  @override
  Future<Either<bool,List<PaymentStatesModel>>> getCachedStates() async {
    if((await box())!.containsKey('keyStates')){
      final data = (await box())!.get('keyStates') as List<dynamic>;
      final List<PaymentStatesModel> paymentStatesModel = data
          .map((e) =>
          PaymentStatesModel(stateId: e.stateId, stateName: e.stateName))
          .toList()
          .cast<PaymentStatesModel>();

      return right(paymentStatesModel);
    }else{
      return left(false);
    }

  }

  @override
  Future<void> setCachedCities(
      {required List<PaymentCitiesModel> models,required int stateId}) async {
    await (await box())!.put('keyCities$stateId', models);
  }

  @override
  Future<Either<bool,List<PaymentCitiesModel>>> getCachedCities({required int stateId}) async {
    if((await box())!.containsKey('keyCities$stateId')){
      final data = (await box())!.get('keyCities$stateId') as List<dynamic>;
      final List<PaymentCitiesModel> paymentCitiesModel = data
          .map((e) => PaymentCitiesModel(cityId: e.cityId, cityName: e.cityName))
          .toList()
          .cast<PaymentCitiesModel>();
      return right(paymentCitiesModel);
    }else{
      return left(false);
    }

  }

  @override
  Future<void> setCachedSubscriptions({required List<PaymentSubscriptionModel> models,required int serviceId})async {
    (await box())!.put('keySubscriptionModel$serviceId', models);
  }

  @override
  Future<Either<bool, List<PaymentSubscriptionModel>>> getCachedSubscriptions({required int serviceId})async {
    if((await box())!.containsKey('keySubscriptionModel$serviceId')){
      final data=(await box())!.get('keySubscriptionModel$serviceId') as List<dynamic>;
      final List<PaymentSubscriptionModel>paymentSubscriptionModel=
          data.map((e) => PaymentSubscriptionModel(
            id: e.id,
            periodName: e.periodName,
            isDiscount: e.isDiscount,
            subPeriodCost:e.subPeriodCost,
            discountCost: e.discountCost,
            discountPercent:e.discountPercent,
          )).toList();

      return right(paymentSubscriptionModel);
    }else{
      return left(false);
    }

  }

  @override
  Future<Either<bool, List<PublicTranslatorEntity>>> getPaymentViewTrans({required int viewId})async {
    if((await box())!.containsKey('keyPaymentTrans$viewId')){
      final data=(await box())!.get('keyPaymentTrans$viewId') as List<dynamic>;
      final List<PublicTranslatorEntity>entities=data.map((e) => PublicTranslatorEntity(
        id: e.id,
        key: e.key,
        val: e.val
      )).toList();
      return right(entities);
    }else{
      return left(false);
    }
  }

  @override
  Future<void> setPaymentViewTrans({required List<PublicTranslatorEntity> models,required int viewId})async {
    (await box())!.put('keyPaymentTrans$viewId', models);
  }

  @override
  Future<Either<bool, PaymentFormsResultModel>> getPaymentApplicationResponse()async {
   if((await box())!.containsKey('keyPaymentApplicationResponse')){
     final data=(await box())!.get('keyPaymentApplicationResponse') ;
     final dataToObject=PaymentFormsResultModel(result: data.result,orderNumber: data.orderNumber,password: data.password);
     return right(dataToObject);
   }else{
     return left(false);
   }
  }

  @override
  Future<void> setPaymentApplicationResponse({required PaymentFormsResultModel paymentFormsResultModel})async {
    (await box())!.put('keyPaymentApplicationResponse', paymentFormsResultModel);
  }


}
