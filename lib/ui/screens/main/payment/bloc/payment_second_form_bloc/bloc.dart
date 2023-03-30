import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../di/dependency_injection.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'events.dart';

class PaymentSecondFormStatesBloc extends Bloc<PaymentSecondFormEvents,GetSecondFormStatesDataState>{
  final PaymentNetworkRepo paymentNetwrokRepo;

  PaymentSecondFormStatesBloc({required this.paymentNetwrokRepo}) : super(GetSecondFormStatesDataState()){
    on((event, emit) async{
   if(event is GetSecondFormStatesDataEvent){
     emit(GetSecondFormStatesDataState.copyWith(message: 'loading...',secondFormResponseStatus: SecondFormResponseStatus.loading));
      try{
        final states=await paymentNetwrokRepo.getStates();
        final trans=await paymentNetwrokRepo.getPaymentUpdatedTrans(viewId: 10);

        emit(GetSecondFormStatesDataState.copyWith(
          message: 'success',
          secondFormResponseStatus: SecondFormResponseStatus.success,
          paymentStatesModel: states,
          publicTranslatorEntity: trans,
        ));
      }catch(e){
        emit(GetSecondFormStatesDataState.copyWith(
          message: sl<DioErrorsImpl>().dioErrorMessage,
          secondFormResponseStatus: SecondFormResponseStatus.error
        ));
      }
   }
    });
  }

}

class PaymentSecondFormCitiesBloc extends Bloc<PaymentSecondFormEvents,GetSecondFormCitiesDataState>{
  final PaymentNetworkRepo paymentNetwrokRepo;

  PaymentSecondFormCitiesBloc({required this.paymentNetwrokRepo}) : super(GetSecondFormCitiesDataState()){
    on((event, emit) async{
      if(event is GetSecondFormCitiesDataEvent){
        emit(GetSecondFormCitiesDataState.copyWith(message: 'loading ...',secondFormResponseStatus: SecondFormResponseStatus.loading));
        try{
          // final states=await paymentNetwrokRepo.getStates();
          final cities=await paymentNetwrokRepo.getCities(stateId: event.stateId);

          emit(GetSecondFormCitiesDataState.copyWith(
            message: 'success',
            secondFormResponseStatus: SecondFormResponseStatus.success,
            paymentCitiesModel: cities,
          ));
        }catch(e){
          print(e);
          emit(GetSecondFormCitiesDataState.copyWith(
              message: sl<DioErrorsImpl>().dioErrorMessage,
              secondFormResponseStatus: SecondFormResponseStatus.error
          ));
        }
      }
      if(event is RebuildEvent){
        emit(GetSecondFormCitiesDataState());
        try{
          final cities=await paymentNetwrokRepo.getCities(stateId: event.stateId);

          emit(GetSecondFormCitiesDataState.copyWith(
            message: 'success',
            secondFormResponseStatus: SecondFormResponseStatus.success,
            paymentCitiesModel: cities,
          ));
        }catch(e){
          print(e);
          emit(GetSecondFormCitiesDataState.copyWith(
              message: sl<DioErrorsImpl>().dioErrorMessage,
              secondFormResponseStatus: SecondFormResponseStatus.error
          ));
        }
      }
    });
  }

}

class PaymentSecondFormSubscriptionsBloc extends Bloc<PaymentSecondFormEvents,GetSecondFormSubscriptionsDataStates>{
 final PaymentNetworkRepo paymentNetworkRepo;
  PaymentSecondFormSubscriptionsBloc({required this.paymentNetworkRepo}):super(GetSecondFormSubscriptionsDataStates()){
   on((event, emit) async{
     if(event is GetSecondFormSubscriptionsDataEvent){
       emit(GetSecondFormSubscriptionsDataStates.copyWith(secondFormResponseStatus: SecondFormResponseStatus.loading));
       try{
         final subscriptions=await paymentNetworkRepo.getSubscriptions(serviceId: event.serviceId!);
         emit(GetSecondFormSubscriptionsDataStates.copyWith(
           secondFormResponseStatus: SecondFormResponseStatus.success,
           paymentSubscriptionModel: subscriptions
         ));
       }catch(e){
         print(e);
         emit(GetSecondFormSubscriptionsDataStates.copyWith(
           message: sl<DioErrorsImpl>().dioErrorMessage,
           secondFormResponseStatus: SecondFormResponseStatus.error
         ));
       }
     }
   });
  }
}