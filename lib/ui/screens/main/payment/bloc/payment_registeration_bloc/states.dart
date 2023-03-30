import '../../../../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../../../../models/entities/payment_entities/payment_forms_resualt_model.dart';

abstract class PaymentRegistrationStates{}
enum PaymentRegistrationResponseStatus{init,loading,error,success}

class PostUserDataState extends PaymentRegistrationStates{
  final String?message;
  final PaymentRegistrationResponseStatus?paymentRegistrationResponseStatus;
  final PaymentFormsResultModel?paymentFormsResultModel;

  PostUserDataState({this.message,this.paymentFormsResultModel,this.paymentRegistrationResponseStatus=PaymentRegistrationResponseStatus.init});

  PostUserDataState.copyWith({this.message,this.paymentRegistrationResponseStatus,this.paymentFormsResultModel});
}

class GetFourthFormTransDataState extends PaymentRegistrationStates{
  final String?message;
  final PaymentRegistrationResponseStatus?paymentRegistrationResponseStatus;
  final List<PublicTranslatorEntity>?trans;


  GetFourthFormTransDataState({this.trans,this.message,this.paymentRegistrationResponseStatus=PaymentRegistrationResponseStatus.init});
  GetFourthFormTransDataState.copyWith({this.trans,this.message,this.paymentRegistrationResponseStatus});
}

