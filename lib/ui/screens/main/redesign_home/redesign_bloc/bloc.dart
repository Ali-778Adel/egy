import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/redesign_home/redesign_bloc/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/dependency_injection.dart';
import '../../../../../repository/networks/home_repo/home_network_repo.dart';
import 'events.dart';

class HomeViewBloc extends Bloc<HomeViewEvents, HomeViewStates> {
  final HomeNetworkRepo homeNetworkRepo;
  HomeViewBloc({required this.homeNetworkRepo})
      : super(GetHomeTranslatorsState()) {
    on((event, emit) async {
      if (event is GetHomeTranslatorsEvent) {
        emit(GetHomeTranslatorsState.copyWith(
          message: 'loading...',
          homeViewResponseStatus: HomeViewResponseStatus.loading,
        ));

        try {
          if(!sl<ThemeBloc>().isThereUpdate){
            print('no updates!!!!!!!');
            final response = await homeNetworkRepo.getHomeTranslators(viewId: 7);
            emit(GetHomeTranslatorsState.copyWith(
                homeViewResponseStatus: HomeViewResponseStatus.success,
                publicTranslatorsEntity: response,
                message: 'success'));
          }else{
            print('there is updates !!!!!');
            final updates=await homeNetworkRepo.getTransUpdates(viewId: 7);
            emit(GetHomeTranslatorsState.copyWith(
                homeViewResponseStatus: HomeViewResponseStatus.success,
                publicTranslatorsEntity: updates,
                message: 'success'));
          }


        } catch (e) {
          debugPrint('error on home view bloc $e');
          emit(GetHomeTranslatorsState.copyWith(
              message: sl<DioErrorsImpl>().dioErrorMessage,
              homeViewResponseStatus: HomeViewResponseStatus.error));
        }
      }
    });
  }
}
