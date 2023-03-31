import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../di/dependency_injection.dart';
import '../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../models/utils/app_preference.dart';

abstract class SDLocalData{
  Future<void>setSDConfigsData({required SdConfigsEntity sdConfigsEntity});

  Future<Either<bool,SdConfigsEntity>>getSDConfigsData();

}
class SDLocalDataImpl implements SDLocalData{
  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<Either<bool, SdConfigsEntity>> getSDConfigsData()async {
    try{
      if((await box())!.containsKey('keySDConfigsData')){
       final data =(await box())!.get('keySDConfigsData');
       final model=SdConfigsEntity(pinCode: data.pinCode,signatureCode: data.signatureCode,secretKey:data.secretKey);
       return right(model);
      }else{
        return left(false);
      }
    }catch(e){
      debugPrint('error in get cache $e');
      throw ('$e');
    }

  }

  @override
  Future<void> setSDConfigsData({required SdConfigsEntity sdConfigsEntity})async {
    (await box())!.put('keySDConfigsData', sdConfigsEntity);
  }

}