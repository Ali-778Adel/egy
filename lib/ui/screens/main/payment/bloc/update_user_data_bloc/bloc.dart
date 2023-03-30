import 'package:fl_egypt_trust/data/local_data_source/payment/payment_local_data.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/update_user_data_bloc/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../di/dependency_injection.dart';
import '../../../../../../models/entities/payment_entities/payment_forms_resualt_model.dart';
import '../../../../../../repository/common_function/handle_dio_error_excptions.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'events.dart';

class PaymentUpdateUserDataBloc extends Bloc<UpdateUserDataEvent,UpdateUserDataState>{
  final PaymentNetworkRepo paymentNetworkRepo;
  PaymentFormsResultModel ?cachedData;


  PaymentUpdateUserDataBloc({required this.paymentNetworkRepo}) : super(UpdateUserDataState()){
    on((event, emit)async{
      if(event is UpdateUserDataEvent){
        emit(UpdateUserDataState.copyWith(message: 'loading...',paymentRegistrationResponseStatus: PaymentUpdateResponseStatus.loading));
        try{
          final data= await paymentNetworkRepo.updateUserData(body: event.requestBody!);
          final lastData=await sl<PaymentLocalData>().getPaymentApplicationResponse();
          lastData.fold((l) => l, (r) {cachedData=r;});

              emit(UpdateUserDataState.copyWith(
                  message:data['msg']??'تم تحديث الملفات ',
                  paymentFormsResultModel: cachedData,
                  paymentRegistrationResponseStatus: PaymentUpdateResponseStatus.success,response: data));
        }catch(e,s){
          debugPrint('error on post user registration data1$e $s');
          emit(UpdateUserDataState.copyWith(message: sl<DioErrorsImpl>().dioErrorMessage,paymentRegistrationResponseStatus: PaymentUpdateResponseStatus.error),
          );
        }
      }
    });
  }

}
