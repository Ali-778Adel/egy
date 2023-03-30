import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../di/dependency_injection.dart';
import '../../../../../../repository/common_function/handle_dio_error_excptions.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';

class PaymentRegistrationBloc extends Bloc<PostUserDataEvent,PostUserDataState>{
  final PaymentNetworkRepo paymentNetworkRepo;

  PaymentRegistrationBloc({required this.paymentNetworkRepo}) : super(PostUserDataState()){
    on((event, emit)async{
   if(event is PostUserDataEvent){
     emit(PostUserDataState.copyWith(message: 'loading...',paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.loading));
     try{
      final data= await paymentNetworkRepo.postUserData(body: event.requestBody!);

      if(data!.result!.isNotEmpty){
        final result=int.parse(data.result!);
        if(result==1){
          emit(PostUserDataState.copyWith(message: 'success',paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.success,paymentFormsResultModel: data));
        }else{
          print('emitted');
         emit(PostUserDataState.copyWith(message: data.msg??'حدث خطأ ما يرجي المحاولة لاحقا ',paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.error));
        }
      }else{
        print('emitted1');
        emit(PostUserDataState.copyWith(message: 'unknown error happened,tyr again later',paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.error));
      }
     }catch(e,s){
       debugPrint('error on post user registration data1$e $s');
       emit(PostUserDataState.copyWith(message: sl<DioErrorsImpl>().dioErrorMessage,paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.error),
       );
     }

   }


    });
  }

}

class PaymentFourthScreensTransBloc extends Bloc<PaymentRegistrationEvents,GetFourthFormTransDataState>{
  final PaymentNetworkRepo paymentNetworkRepo;
  PaymentFourthScreensTransBloc({required this.paymentNetworkRepo}) : super(GetFourthFormTransDataState()){
    on((event, emit)async{
      if(event is GetFourthFormTransDataEvent){
        emit(GetFourthFormTransDataState.copyWith(paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.loading));
        try{
          final transData=await paymentNetworkRepo.getPaymentUpdatedTrans(viewId: 12);
          emit(GetFourthFormTransDataState.copyWith(message: 'success',trans: transData,paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.success));
        }catch(e){
          emit(GetFourthFormTransDataState.copyWith(message: sl<DioErrorsImpl>().dioErrorMessage,paymentRegistrationResponseStatus: PaymentRegistrationResponseStatus.error));
        }
      }
    });
  }

}