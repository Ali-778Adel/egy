import '../../../../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../../../../models/entities/payment_entities/payment_service_status_model.dart';
import '../../../../../../models/entities/payment_entities/payment_service_type_model.dart';

abstract class PaymentFirstFormStates{}

class FirstFormInitState extends PaymentFirstFormStates{}

class GetFirstFormDataStates extends PaymentFirstFormStates{
  final FirstFormStatus ?firstFormStatus;
  final String?message;
  final List<PaymentServiceStatusModel>?paymentServiceStatusModels;
  final List<PaymentServiceTypeModel>?paymentServiceTypeModels;
  final List<PublicTranslatorEntity>?publicTranslatorEntity;

  GetFirstFormDataStates({this.publicTranslatorEntity,this.firstFormStatus,this.message,this.paymentServiceStatusModels,this.paymentServiceTypeModels});

}


enum FirstFormStatus{loading,error,success}