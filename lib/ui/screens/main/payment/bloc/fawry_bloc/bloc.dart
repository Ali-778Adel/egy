import 'dart:convert';
import 'dart:math';

import 'package:fl_egypt_trust/data/services/fawry_payment_service.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../di/dependency_injection.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'bloc_events.dart';
import 'bloc_states.dart';

class FawryBloc extends Bloc<FawryEvents, FawryStates> {
  final PaymentNetworkRepo paymentNetworkRepo;
  String?userRefNumber;

  FawryBloc({required this.paymentNetworkRepo}) : super(FawryInitState()) {
    on((event, emit) async {
      if (event is InitiateFawryPaymentEvent) {
        userRefNumber=event.userRefNumber;
        print('event strated');
        emit(FawryInitiateStates());
        print('state emitted');
         await sl<FarwryPaymentService>().initiateSDK(price: event.price,merchantRefNumber: event.merchantRefNumber,customerMail: event.customerMail,customerMobile: event.customerMobile);
      }
      if(event is StartFawryCallBackResponseEvent){
        print('event is :  StartFawryCallBackResponseEvent ///////////////////');
        switch(event.fawryCallBackResponsStatus){
          case FawryCallBackResponsStatus.error:{
            print('event is :  StartFawryCallBackResponseEvent with error ///////////////////');
            emit(FawryCallBackState(paymentProcessStatus: PaymentProcessStatus.error,message: event.message, ));
          }break;
          case FawryCallBackResponsStatus.success:{
            print('event is :  StartFawryCallBackResponseEvent with success ///////////////////');
            print(event.response);
            Map<String,dynamic>paymentResponse=json.decode(event.response!);
            print('files is ${paymentResponse}');
              final Map<String,dynamic>x={
                "customerMail":"${paymentResponse['customerMail']}",
                "customerMobile":"${paymentResponse['customerMobile']}",
                "expirationTime":"${paymentResponse['expirationTime']}",
                "fawryFees":paymentResponse['fawryFees'],
                "merchantRefNumber":"${paymentResponse['merchantRefNumber']}",
                "orderAmount":"${paymentResponse['orderAmount']}",
                "orderStatus":"${paymentResponse['orderStatus']}",
                "paymentAmount":"${paymentResponse['paymentAmount']}",
                "paymentMethod":"${paymentResponse['paymentMethod']}",
                "referenceNumber":"$userRefNumber",
                "shippingFees":paymentResponse['shippingFees'],
                "signature":"${paymentResponse['signature']}",
                "taxes":paymentResponse['taxes'],
                "statusCode":paymentResponse['statusCode'],
                "statusDescription":"${paymentResponse['statusDescription']}",
                "type":"${paymentResponse['type']}"};
              print('userRefNumber=$userRefNumber');
            final data=await paymentNetworkRepo.postPaymentResponse(json: x);
            if(data==200){
              try{
                sl<AppPreference>().setPaymentOrderRefNumber(merchantNumber: paymentResponse['merchantRefNumber'], orderRefNumber: paymentResponse['referenceNumber']);
                debugPrint('${paymentResponse['merchantRefNumber']}');
                debugPrint('${paymentResponse['referenceNumber']}');
                print('orderRefNumber CachedSuccessfully************************************************');
              }catch(e){
                print('error on cha ordernumber $e');
              }

             try{
               emit(FawryCallBackState(paymentProcessStatus: PaymentProcessStatus.success,message: event.message,response: paymentResponse));

             }catch(e){
               print('exception in emit this one $e');
             }
            }else{
              emit(FawryCallBackState(paymentProcessStatus: PaymentProcessStatus.error,message: event.message, ));
            }
          }break;
          case FawryCallBackResponsStatus.completed:{
            print('event is :  StartFawryCallBackResponseEvent with completed ///////////////////');

            emit(FawryCallBackState(paymentProcessStatus: PaymentProcessStatus.completed,message: event.message,response:json.decode( event.response!)));

          }break;
          default:{
            print('event is :  StartFawryCallBackResponseEvent with default ///////////////////');

            emit(FawryCallBackState(paymentProcessStatus: PaymentProcessStatus.loading,message: event.message,response: json.decode(event.response!)));

          }
        }
      }
    });
  }
}
