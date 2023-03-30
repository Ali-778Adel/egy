import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../models/utils/app_preference.dart';

abstract class ProfileLocalData{
  Future<void>setProfileTranslators({required List<PublicTranslatorEntity>models});
  Future<Either<bool,List<PublicTranslatorEntity>>>geProfileTranslators();
}

class ProfileLocalDataImpl implements ProfileLocalData{
  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<void> setProfileTranslators({required List<PublicTranslatorEntity> models})async {
    (await box())!.put('keyProfileTranslators', models);

  }


  @override
  Future<Either<bool, List<PublicTranslatorEntity>>> geProfileTranslators()async {
    if((await box())!.containsKey('keyProfileTranslators')){
      final data = (await box())!.get('keyProfileTranslators') as List<dynamic>;
      final List<PublicTranslatorEntity>translators=data.map<PublicTranslatorEntity>((e){
        return PublicTranslatorEntity(
            id:e.id,
            view: e.view,
            key: e.key,
            val: e.val
        );
      }).toList();
      return right(translators);
    }else{
      return left(false);
    }
  }
}