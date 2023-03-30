import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';

import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/repository/networks/appointment_network/appointment_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'branches_cubit_state.dart';

class BranchesCubit extends Cubit<BranchesCubitState> {
  BranchesCubit(BranchesCubitState initialState) : super(initialState);



  getBranchesList(int? cityId)async{

    emit(state.copyWith(isCitiesLoading : true ,  cityBranches: []));
    final client = await _getClient();
    EnumLanguage lang = await AppPreference.instance.getLocale();
    await client.getBranches(lang : lang.localeValue(),cityId : cityId)
        .then((response) {
      logger.i(response.data?.toJson());

      emit(state.copyWith(isCitiesLoading : false , allCities: response.data?.cities , cityBranches: response.data?.branches));


    }).onError((error, stackTrace) {
      emit(state.copyWith(isCitiesLoading : false ,));
      logger.e(error);
    });



  }





  Future<AppointmentClient> _getClient() async {
   Dio? dio = await AppPreference.instance.getRequestHeader();
   // dio = NetworkLogger().addInterceptors(dio);
    return AppointmentClient(dio);
  }


}
