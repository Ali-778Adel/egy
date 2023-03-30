import '../../../../../models/entities/payment_auth/payment_auth_model.dart';

class PaymentAuthStates{
  final String?message;
  final PaymentAuthResponseStatus?paymentAuthResponseStatus;
  final PaymentAuthModel?paymentAuthModel;
  PaymentAuthStates({this.message,this.paymentAuthResponseStatus=PaymentAuthResponseStatus.init,this.paymentAuthModel});
  PaymentAuthStates.copyWith({this.message,this.paymentAuthResponseStatus,this.paymentAuthModel});

}
enum PaymentAuthResponseStatus{init,loading,success,error}

