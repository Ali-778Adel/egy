import '../../../../../../models/entities/home_entities/home_translator_entity.dart';

enum PaymentThirdFormResponseStatus{init,loading,success,error}

class GetPaymentThirdFormDataStates{
  final PaymentThirdFormResponseStatus ?paymentThirdFormResponseStatus;
  final String?message;
  final List<PublicTranslatorEntity>?publicTranslatorsEntity;

  GetPaymentThirdFormDataStates({this.paymentThirdFormResponseStatus=PaymentThirdFormResponseStatus.init,this.message,this.publicTranslatorsEntity});
  GetPaymentThirdFormDataStates.copyWith({this.paymentThirdFormResponseStatus,this.message,this.publicTranslatorsEntity});

}

