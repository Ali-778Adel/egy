import 'package:fl_egypt_trust/ui/screens/main/follow_orders_login/bloc/states.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment_auth/blocs/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/networks/payment_auth/paymnet_auth_network_repo.dart';
import 'events.dart';

class FollowOrderLoginBloc extends Bloc<FollowOrderLoginEvents,FollowOrderLoginStates>{
  final PaymentAuthNetworkRepo paymentAuthNetworkRepo;
  FollowOrderLoginBloc({required this.paymentAuthNetworkRepo}) : super(FollowOrderLoginStates()){
    on((event, emit) async{
      if(event is FollowOrderLoginEvents){
        emit(FollowOrderLoginStates.copyWith(paymentAuthResponseStatus: FollowOrdersLoginResponseStatus.loading));
        try{
          final data=await paymentAuthNetworkRepo.paymentLogin(data: event.body!);
          emit(FollowOrderLoginStates.copyWith(paymentAuthResponseStatus: FollowOrdersLoginResponseStatus.success,paymentAuthModel: data));
        }catch(e){
          emit(FollowOrderLoginStates.copyWith(paymentAuthResponseStatus: FollowOrdersLoginResponseStatus.error));
        }
      }
    }) ;
  }


}
