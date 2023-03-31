import 'package:fl_egypt_trust/di/dependency_injection.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/networks/profile_repo/profile_network_repo.dart';
import 'events.dart';

class ProfileTransBloc extends Bloc<ProfileTransEvent,ProfileTransStates>{
  final ProfileNetworkRepo profileNetworkRepo;
  ProfileTransBloc({required  this.profileNetworkRepo}) : super(ProfileTransStates()){
   on((event, emit)async {
     if(event is ProfileTransEvent){
       emit(ProfileTransStates.copyWith(message: 'loading',profileViewResponseStatus: ProfileViewResponseStatus.loading));
     try{
       final data=await profileNetworkRepo.getTransUpdates();
       emit(ProfileTransStates.copyWith(message: 'success',profileViewResponseStatus: ProfileViewResponseStatus.success
       ,transEntities: data
       ));
     }catch(e){
       emit(ProfileTransStates.copyWith(message: sl<DioErrorsImpl>().dioErrorMessage,
       profileViewResponseStatus: ProfileViewResponseStatus.error
       ));
     }
     }
   });
  }

}