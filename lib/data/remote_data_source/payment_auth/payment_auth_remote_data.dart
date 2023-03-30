import 'package:flutter/cupertino.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/payment_auth/payment_auth_model.dart';
import '../../local_data_source/payment_auth/payment_auth_local_data/payment_auth_local_data.dart';
import '../../services/dio/dio_client.dart';
import '../../services/dio/list_api.dart';

abstract class PaymentAuthRemoteData{
  Future<PaymentAuthModel>paymentLogin({required Map<String,dynamic>body});
}

class PaymentAuthRemoteDataImpl implements PaymentAuthRemoteData{
  @override
  Future<PaymentAuthModel> paymentLogin({required Map<String,dynamic>body})async {
    final response=await sl<DioClientService>().postRequest('${ListApi.userCheckLogin}/${body['CardId']}/${body['userRef']}',);
    final json=response.data;
    final jsonToModel=PaymentAuthModel.fromJson(json: json);
    await sl<PaymentAuthLocalData>().setUserData(paymentAuthModel: jsonToModel);
    return jsonToModel;

  }

}