
import '../../../../../../models/entities/payment_entities/payment_forms_resualt_model.dart';

enum PaymentUpdateResponseStatus{init,loading,error,success}

class UpdateUserDataState {
  final String?message;
  final PaymentUpdateResponseStatus?paymentRegistrationResponseStatus;
  final dynamic response;
  final PaymentFormsResultModel?paymentFormsResultModel;

  UpdateUserDataState({this.paymentFormsResultModel,this.response,this.message,this.paymentRegistrationResponseStatus=PaymentUpdateResponseStatus.init});

  UpdateUserDataState.copyWith({this.message,this.paymentRegistrationResponseStatus,this.response,this.paymentFormsResultModel});
}
