import 'package:fl_egypt_trust/di/dependency_injection.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/branches/blocs/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/networks/branches_repo/branches_network_repo.dart';
import 'events.dart';

class BranchesBloc extends Bloc<BranchesEvents,BranchesStates>{
  final BranchesNetworkRepo branchesNetworkRepo;
  BranchesBloc({required this.branchesNetworkRepo}) : super( BranchesInitState()){
    on((event, emit)async{
      if(event is GetBranchesEvent){
        emit(GetBranchesStates(message: 'loading',branchesResponseStatus: BranchesResponseStatus.loading));
        try{
          final data=await branchesNetworkRepo.getAllBranches(stateId: event.stateId!,cityId: event.cityId!);
          emit(GetBranchesStates(
              message: 'success',
              branchesModels: data,
              branchesResponseStatus:
          BranchesResponseStatus.success));
        }catch(e){
          emit(GetBranchesStates(message: sl<DioErrorsImpl>().dioErrorMessage,branchesResponseStatus: BranchesResponseStatus.error));
        }
      }

    });

  }


  // @override
  // Stream<BranchesStates>mapEventToState(BranchesEvents events)async*{
  //   if(events is GetBranchesEvent){
  //    yield(GetBranchesStates(message: 'loading',branchesResponseStatus: BranchesResponseStatus.loading));
  //    try{
  //      final data=await branchesNetworkRepo.getAllBranches();
  //      yield(GetBranchesStates(message: 'success',branchesModels: data,branchesResponseStatus: BranchesResponseStatus.success));
  //    }catch(e){
  //      yield(GetBranchesStates(message: sl<DioErrorsImpl>().dioErrorMessage,branchesResponseStatus: BranchesResponseStatus.error));
  //    }
  //   }
  // }
}