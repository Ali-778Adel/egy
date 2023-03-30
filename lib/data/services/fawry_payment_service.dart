import 'dart:async';
import 'dart:convert';

import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fawry_sdk/model/bill_item.dart';
import 'package:fawry_sdk/model/fawry_launch_model.dart';
import 'package:fawry_sdk/model/launch_customer_model.dart';
import 'package:fawry_sdk/model/launch_merchant_model.dart';
import 'package:fawry_sdk/model/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../ui/screens/main/payment/bloc/fawry_bloc/bloc.dart';
import '../../ui/screens/main/payment/bloc/fawry_bloc/bloc_events.dart';

class FarwryPaymentService {
  FarwryPaymentService();


  late StreamSubscription? _fawryCallbackResultStream;
  Future<void> initSDKCallback(BuildContext context) async {
    try {
      _fawryCallbackResultStream =
          FawrySdk.instance.callbackResultStream().listen(

                  (event) {
        ResponseStatus response = ResponseStatus.fromJson(jsonDecode(event));
        switch (response.status) {
          case FawrySdk.RESPONSE_SUCCESS:
            {

              //Success status
              debugPrint('Message : ${response.message}');
              //Success json response
              debugPrint('Json Response : ${response.data}');

              BlocProvider.of<FawryBloc>(context).add(StartFawryCallBackResponseEvent(
                  fawryCallBackResponsStatus: FawryCallBackResponsStatus.success,
                  message: response.message,
                  response: response.data,

              ));
            }
            break;
          case FawrySdk.RESPONSE_ERROR:
            {
              debugPrint('Error : ${response.message}');
              BlocProvider.of<FawryBloc>(context).add(StartFawryCallBackResponseEvent(
                fawryCallBackResponsStatus: FawryCallBackResponsStatus.error,
                message: response.message,

              ));
            }
            break;
          case FawrySdk.RESPONSE_PAYMENT_COMPLETED:
            {
              debugPrint(
                  'Payment Completed : ${response.message} , ${response.data}');

              BlocProvider.of<FawryBloc>(context).add(StartFawryCallBackResponseEvent(
                fawryCallBackResponsStatus: FawryCallBackResponsStatus.completed,
                message: response.message,
                response: response.data,
              ));
            }
            break;
        }
      });
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }


  Future<void> initiateSDK({required double price,required  String merchantRefNumber,required String customerMail,required String customerMobile}) async {
    BillItem item =
    BillItem(itemId: "6b5fdea340e31b3b0339d4d4ae5", description: "Product Description", quantity: 1, price: price);

    List<BillItem>? chargeItems = [item];

    LaunchCustomerModel customerModel = LaunchCustomerModel(
        customerName: "customer name",
        customerEmail: customerMail,
        customerMobile: customerMobile);

    LaunchMerchantModel merchantModel = LaunchMerchantModel(
      merchantCode: "dJWmdV+lPIE=",
      merchantRefNum: merchantRefNumber,
      secureKey: "2ca4c078ab0d4c50ba90e31b3b0339d4d4ae5b32f97092dd9e9c07888c7eef36",
    );

    FawryLaunchModel model = FawryLaunchModel(
        allow3DPayment: true,
        chargeItems: chargeItems,
        launchCustomerModel: customerModel,
        launchMerchantModel: merchantModel,
        skipLogin: true,
        skipReceipt: true,
        payWithCardToken: false //This flag enables/disables user cards tokenization,
      //if 'payWithCardToken' is enabled you need to define customerProfileId in LaunchCustomerModel
    );

    await FawrySdk.instance.init(
        launchModel: model,
        baseURL: "https://atfawry.fawrystaging.com/", // You will need to change this url when you go live
        lang: FawrySdk.LANGUAGE_ENGLISH);
  }
}

