import '../../../../../models/entities/payment_auth/payment_auth_model.dart';

class FollowOrderLoginStates{
  final String?message;
  final FollowOrdersLoginResponseStatus?paymentAuthResponseStatus;
  final PaymentAuthModel?paymentAuthModel;
  FollowOrderLoginStates({this.message,this.paymentAuthResponseStatus=FollowOrdersLoginResponseStatus.init,this.paymentAuthModel});
  FollowOrderLoginStates.copyWith({this.message,this.paymentAuthResponseStatus,this.paymentAuthModel});

}
enum FollowOrdersLoginResponseStatus{init,loading,success,error}

