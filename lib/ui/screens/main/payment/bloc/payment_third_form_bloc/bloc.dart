import 'package:fl_egypt_trust/di/dependency_injection.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_third_form_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../repository/common_function/handle_dio_error_excptions.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'events.dart';

class PaymentThirdFormBloc extends Bloc<GetPaymentThirdFormBlocEvent,GetPaymentThirdFormDataStates>{
  final PaymentNetworkRepo paymentNetwrokRepo;
  PaymentThirdFormBloc({required this.paymentNetwrokRepo}) : super(GetPaymentThirdFormDataStates()){
    on((event, emit)async {
      emit(GetPaymentThirdFormDataStates.copyWith(paymentThirdFormResponseStatus: PaymentThirdFormResponseStatus.loading));
      try{
        final trans=await paymentNetwrokRepo.getPaymentUpdatedTrans(viewId: 11);
        emit(GetPaymentThirdFormDataStates.copyWith(
            paymentThirdFormResponseStatus: PaymentThirdFormResponseStatus.success,
            publicTranslatorsEntity: trans,
          message: 'success',
        ));
      }catch(e){
        emit(GetPaymentThirdFormDataStates.copyWith(
            paymentThirdFormResponseStatus: PaymentThirdFormResponseStatus.error,
            message: sl<DioErrorsImpl>().dioErrorMessage,
        ));
      }


    });
  }

}