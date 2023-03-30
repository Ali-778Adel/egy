import '../../../../../../models/entities/payment_entities/folllow_order_model.dart';
import '../../../../../../models/entities/payment_entities/payment_forms_resualt_model.dart';

enum FollowOrdersResponseStatus{init,loading,success,error}
class FollowOrderStates{
  final String?message;
  final PaymentFormsResultModel?paymentFormsResultModel;
  final List<FollowOrderModel>?followOrdersModels;
  final FollowOrdersResponseStatus ?followOrdersResponseStatus;

  FollowOrderStates({this.paymentFormsResultModel,this.followOrdersResponseStatus=FollowOrdersResponseStatus.init,this.message,this.followOrdersModels});
  FollowOrderStates.copyWith({this.paymentFormsResultModel,this.followOrdersResponseStatus,this.message,this.followOrdersModels});
}