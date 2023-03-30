import 'package:fl_egypt_trust/models/entities/payment_entities/payment_forms_resualt_model.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/follow_order_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/local_data_source/payment/payment_local_data.dart';
import '../../../../../../di/dependency_injection.dart';
import '../../../../../../repository/networks/payment/payment_network.dart';
import 'events.dart';

class FollowOrderBloc extends Bloc<FollowOrderEvent, FollowOrderStates> {
  final PaymentNetworkRepo paymentNetworkRepo;
  final PaymentLocalData paymentLocalData;
  PaymentFormsResultModel ?cachedData;
  FollowOrderBloc({required this.paymentNetworkRepo,required this.paymentLocalData})
      : super(FollowOrderStates()) {
    on((event, emit) async {
      if (event is FollowOrderEvent) {
        emit(FollowOrderStates.copyWith(
            followOrdersResponseStatus: FollowOrdersResponseStatus.loading,
            message: 'loading'));
        try {

          final lastData=await paymentLocalData.getPaymentApplicationResponse();
          lastData.fold((l) => l, (r) {cachedData=r;});

          final data = await paymentNetworkRepo.followPaymentOrders();
          // print(cachedData!.orderNumber);
          emit(FollowOrderStates.copyWith(
              followOrdersResponseStatus: FollowOrdersResponseStatus.success,
              paymentFormsResultModel: cachedData,
               followOrdersModels: data,
              message: 'success'));
        } catch (e, s) {
          print('exeption """"""""""""";f][pogdpoi $e $s');
          emit(FollowOrderStates.copyWith(
              message: sl<DioErrorsImpl>().dioErrorMessage,
              followOrdersResponseStatus: FollowOrdersResponseStatus.error));
        }
      }
    });
  }


}
