import '../../../di/dependency_injection.dart';
import '../../../models/entities/branches/branches_model.dart';
import '../../local_data_source/branches/branches_local_data.dart';
import '../../services/dio/dio_client.dart';
import '../../services/dio/list_api.dart';

abstract class BranchesRemoteData{
  Future<List<BranchesModel>>getBranches({required String cityId,required String stateId});
}

class BranchesRemoteDataImpl implements BranchesRemoteData{
  
  @override
  Future<List<BranchesModel>> getBranches({required String cityId,required String stateId})async {
    final response=await sl<DioClientService>().getRequest('${ListApi.allBranches}$stateId/$cityId');
    final List json=response.data;
    final jsonToModels=json.map((e) => BranchesModel.fromJson(json: e)).toList();
    await sl<BranchesLocalData>().setBranchesData(models: jsonToModels,stateId: stateId,cityId: cityId);
    return jsonToModels;
  }
}