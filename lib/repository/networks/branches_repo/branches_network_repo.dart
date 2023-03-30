import 'package:fl_egypt_trust/models/entities/branches/branches_model.dart';

import '../../../data/local_data_source/branches/branches_local_data.dart';
import '../../../data/remote_data_source/branches/branches_remote_data.dart';
import '../../../di/dependency_injection.dart';

class BranchesNetworkRepo{
  final BranchesRemoteData branchesRemoteData;
  final BranchesLocalData branchesLocalData;

  BranchesNetworkRepo({required this.branchesLocalData,required this.branchesRemoteData});
  
  Future<List<BranchesModel>>getAllBranches({required String stateId,required String cityId})async{
    try{
      final data=await branchesRemoteData.getBranches(stateId: stateId,cityId: cityId);
      return data;
    }catch(e){
      print('branches exception');
      final data=await sl<BranchesLocalData>().getBranchesCachedData(stateId: stateId,cityId: cityId);
      return data.fold((l)async =>await branchesRemoteData.getBranches(stateId: stateId,cityId: cityId) , (r) => r);
    }

  }
}