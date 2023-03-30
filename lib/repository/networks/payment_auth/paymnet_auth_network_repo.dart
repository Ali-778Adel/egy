import '../../../data/remote_data_source/payment_auth/payment_auth_remote_data.dart';
import '../../../models/entities/payment_auth/payment_auth_model.dart';

class PaymentAuthNetworkRepo{
  final PaymentAuthRemoteData paymentAuthRemoteData;
 PaymentAuthNetworkRepo({required this.paymentAuthRemoteData});

  Future<PaymentAuthModel>paymentLogin({required Map<String,dynamic>data})async{
    return await paymentAuthRemoteData.paymentLogin(body: data);
  }
}