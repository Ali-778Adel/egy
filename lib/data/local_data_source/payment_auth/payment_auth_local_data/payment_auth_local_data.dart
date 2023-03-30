import 'package:hive/hive.dart';

import '../../../../di/dependency_injection.dart';
import '../../../../models/entities/payment_auth/payment_auth_model.dart';
import '../../../../models/utils/app_preference.dart';

abstract class PaymentAuthLocalData{
  Future<void>setUserData({required PaymentAuthModel paymentAuthModel});
  Future<PaymentAuthModel>getUserData();
}

class PaymentAuthLocalDataImpl implements PaymentAuthLocalData{
  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<PaymentAuthModel> getUserData()async {
     final data =(await box())!.get('keyUserData');
     final dataToModel=PaymentAuthModel(
       token: data.token,
       expiration: data.expiration,
     );
   return dataToModel;
  }

  @override
  Future<void> setUserData({required PaymentAuthModel paymentAuthModel})async {
    (await box())!.put('keyUserData',paymentAuthModel );
  }

}