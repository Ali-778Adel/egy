import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_first_form_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../di/dependency_injection.dart';
import '../../../../../../repository/common_function/handle_dio_error_excptions.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'events.dart';

class PaymentFirstFormBloc extends Bloc<PaymentFirstFormEvents,PaymentFirstFormStates>{
  final PaymentNetworkRepo paymentNetworkRepo;

  PaymentFirstFormBloc({required this.paymentNetworkRepo}):super(FirstFormInitState()){
    on((event, emit)async {
      if(event is GetFirstFormDataEvent){

        emit (GetFirstFormDataStates(firstFormStatus: FirstFormStatus.loading,message: 'loading ....'));
        try{
          final types=await paymentNetworkRepo.getServiceType();
          final status=await paymentNetworkRepo.getServiceStatus();
          final trans=await paymentNetworkRepo.getPaymentUpdatedTrans(viewId: 9);

        emit(GetFirstFormDataStates(
          firstFormStatus: FirstFormStatus.success,
          paymentServiceTypeModels: types,
          paymentServiceStatusModels: status,
          publicTranslatorEntity: trans
        ));
        }catch(e){
          print('i am in catch $e');
          emit(GetFirstFormDataStates(firstFormStatus: FirstFormStatus.error,message:sl<DioErrorsImpl>().dioErrorMessage));
        }

      }
    });
  }


}