import 'package:dartz/dartz.dart';
import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';
import 'package:hive/hive.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/theme_enities/colors_entity.dart';
import '../../../models/entities/theme_enities/icons_entity.dart';
import '../../../models/utils/app_preference.dart';

abstract class ThemeLocalData{
  Future<void>setLocalIcons({required List<IconsEntity>iconsModels});
  Future<Either<bool,List<IconsEntity>>>getLocalIcons();
  Future<void>setLocalSliderImages({required List<IconsEntity>iconsModels});
  Future<Either<bool,List<IconsEntity>>>getLocalSliderImages();
  Future<void>setLocalColors({required List<ColorsEntity>iconsModels});
  Future<Either<bool,List<ColorsEntity>>>getLocalColors();
  Future<void>setGeneralLocalTranslators({required List<PublicTranslatorEntity> models,required int viewId});
  Future<Either<bool,List<PublicTranslatorEntity>>>getGeneralLocalTranslators();

}

class ThemeLocalDataImpl implements ThemeLocalData{

  Future<Box<dynamic>?> box() async {
    return await sl<AppPreference>().getPaymentBox();
  }

  @override
  Future<void> setLocalIcons({required List<IconsEntity>iconsModels}) async{
    (await box())!.put('keyAppIcons', iconsModels);
  }

  @override
  Future<Either<bool, List<IconsEntity>>> getLocalIcons()async {
    if((await box())!.containsKey('keyAppIcons')){
      final response=(await box())!.get('keyAppIcons') as List;
      final responseToModels=response.map<IconsEntity>((e) => IconsEntity(
          imageKey: e.imageKey,
          imageUrl: e.imageUrl,
      )).toList();
     return right(responseToModels);
    }else{
      return left(false);
    }

  }



  @override
  Future<void> setLocalColors({required List<ColorsEntity>iconsModels}) async{
    (await box())!.put('keyAppColors', iconsModels);
  }

  @override
  Future<Either<bool, List<ColorsEntity>>> getLocalColors()async {
    if((await box())!.containsKey('keyAppColors')){
      final response=(await box())!.get('keyAppColors') as List;
      final responseToModels=response.map<ColorsEntity>((e) => ColorsEntity(
          id: e.id,
          key: e.key,
          val: e.val
      )).toList();
      return right(responseToModels);
    }else{
      print('left ************************************');
      return left(false);
    }

  }

  @override
  Future<Either<bool,List<PublicTranslatorEntity>>>getGeneralLocalTranslators()async {
    if((await box())!.containsKey('keyGeneralTrans')){
      final data=(await box())!.get('keyGeneralTrans') as List<dynamic>;
      final dataToModel=data.map<PublicTranslatorEntity>((e) => PublicTranslatorEntity(
        id:e.id,
        key: e.key,
        val: e.val,

      )).toList();
      return right(dataToModel);
    }else{
      return left(false);
    }
  }

  @override
  Future<void> setGeneralLocalTranslators({required List<PublicTranslatorEntity> models,required int viewId})async {
    (await box())!.put('keyGeneralTrans', models) ;
  }

  @override
  Future<Either<bool, List<IconsEntity>>> getLocalSliderImages()async {
    if((await box())!.containsKey('keySliderImages')){
    final response=(await box())!.get('keySliderImages') as List;
    final responseToModels=response.map<IconsEntity>((e) => IconsEntity(
    imageKey: e.imageKey,
    imageUrl: e.imageUrl,
    )).toList();
    return right(responseToModels);
    }else{
    return left(false);
    }
  }

  @override
  Future<void> setLocalSliderImages({required List<IconsEntity> iconsModels})async {
    (await box())!.put('keySliderImages', iconsModels);

  }



}