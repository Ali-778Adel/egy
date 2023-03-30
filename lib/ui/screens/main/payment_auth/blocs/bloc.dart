import 'package:fl_egypt_trust/ui/screens/main/payment_auth/blocs/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/networks/payment/payment_network.dart';
import '../../../../../repository/networks/payment_auth/paymnet_auth_network_repo.dart';
import 'events.dart';

class PaymentAuthBloc extends Bloc<PaymentAuthEvents,PaymentAuthStates>{
  final PaymentAuthNetworkRepo paymentAuthNetworkRepo;
  PaymentAuthBloc({required this.paymentAuthNetworkRepo}) : super(PaymentAuthStates()){
   on((event, emit) async{
     if(event is PaymentAuthEvents){
       emit(PaymentAuthStates.copyWith(paymentAuthResponseStatus: PaymentAuthResponseStatus.loading));
       try{
         final data=await paymentAuthNetworkRepo.paymentLogin(data: event.body!);
         emit(PaymentAuthStates.copyWith(paymentAuthResponseStatus: PaymentAuthResponseStatus.success,paymentAuthModel: data));
       }catch(e){
         emit(PaymentAuthStates.copyWith(paymentAuthResponseStatus: PaymentAuthResponseStatus.error));
       }
     }
   }) ;
  }


}

