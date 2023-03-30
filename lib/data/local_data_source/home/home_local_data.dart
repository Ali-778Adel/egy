import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../models/utils/app_preference.dart';

abstract class HomeLocalData{
  Future<void>setHomeTranslators({required List<PublicTranslatorEntity>models,required int viewId});
  Future<Either<bool,List<PublicTranslatorEntity>>>getHomeTranslators({required int viewId});

}

class HomeLocalDataImpl implements HomeLocalData{
  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<void> setHomeTranslators({required List<PublicTranslatorEntity> models,required int viewId})async {
    (await box())!.put('keyHomeTranslators$viewId', models);

  }


  @override
  Future<Either<bool, List<PublicTranslatorEntity>>> getHomeTranslators({required int viewId})async {
   if((await box())!.containsKey('keyHomeTranslators$viewId')){
     final data = (await box())!.get('keyHomeTranslators$viewId') as List<dynamic>;
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