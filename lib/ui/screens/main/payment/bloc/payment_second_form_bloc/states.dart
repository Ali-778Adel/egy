import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_first_form_bloc/states.dart';

import '../../../../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../../../../models/entities/payment_entities/payment_cities_model.dart';
import '../../../../../../models/entities/payment_entities/paymnet_states_model.dart';

enum SecondFormResponseStatus{init,loading,error,success}
abstract class PaymentSecondFormStates{}

class SecondFormInitState extends PaymentSecondFormStates{}

class GetSecondFormStatesDataState extends PaymentSecondFormStates{
  final String?message;
  final SecondFormResponseStatus?secondFormResponseStatus;
  final List<PaymentStatesModel>?paymentStatesModel;
  final List<PublicTranslatorEntity>?publicTranslatorEntity;
  // final List<PaymentCitiesModel>?paymentCitiesModel;

   GetSecondFormStatesDataState({this.publicTranslatorEntity,this.message,this.paymentStatesModel,this.secondFormResponseStatus=SecondFormResponseStatus.init});

   GetSecondFormStatesDataState.copyWith({this.publicTranslatorEntity,this.message,this.secondFormResponseStatus,this.paymentStatesModel});
}


class GetSecondFormCitiesDataState extends PaymentSecondFormStates{
  final String?message;
  final SecondFormResponseStatus?secondFormResponseStatus;
   List<PaymentCitiesModel>?paymentCitiesModel;

  GetSecondFormCitiesDataState({this.message,this.paymentCitiesModel,this.secondFormResponseStatus=SecondFormResponseStatus.init});

  GetSecondFormCitiesDataState.copyWith({this.message,this.secondFormResponseStatus,this.paymentCitiesModel});
}

class GetSecondFormSubscriptionsDataStates extends PaymentSecondFormStates{
  final String?message;
  final List<PaymentSubscriptionModel>?paymentSubscriptionModel;
  final SecondFormResponseStatus ?secondFormResponseStatus;
  GetSecondFormSubscriptionsDataStates({this.message,this.secondFormResponseStatus=SecondFormResponseStatus.init,this.paymentSubscriptionModel});

  GetSecondFormSubscriptionsDataStates.copyWith({this.message,this.paymentSubscriptionModel,this.secondFormResponseStatus});
}