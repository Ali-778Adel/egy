import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/branches/branches_model.dart';
import '../../../models/utils/app_preference.dart';

abstract class BranchesLocalData{
  Future<void>setBranchesData({required List<BranchesModel>models,required String cityId,required String stateId});
  Future<Either<bool,List<BranchesModel>>>getBranchesCachedData({required String cityId,required String stateId});
}

class BranchesLocalDataImpl implements BranchesLocalData{

  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<Either<bool, List<BranchesModel>>> getBranchesCachedData({required String cityId,required String stateId})async {
    if((await box())!.containsKey('keyBranches/$stateId/$cityId')){
      final data = (await box())!.get('keyBranches') as List<dynamic>;
      final dataToModel=data.map((e) => BranchesModel(
        name: e.name,
        address: e.address,
        map: e.map,
        longitude: e.longitude,
        latitude: e.latitude,
      )).toList();
      return right(dataToModel);
    }else{
      return left(false);
    }
  }

  @override
  Future<void> setBranchesData({required List<BranchesModel>models,required String cityId,required String stateId}) async{
    (await box())!.put('keyBranches/$stateId/$cityId', models);
  }

}