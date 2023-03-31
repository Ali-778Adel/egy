import 'package:fl_egypt_trust/models/entities/theme_enities/locale_entity.dart';

import '../../../models/entities/home_entities/home_translator_entity.dart';
import '../../local_data_source/profile/profile_local_data.dart';
import '../../services/dio/dio_client.dart';
import '../../services/dio/list_api.dart';

abstract class ProfileRemoteData{
  Future<List<PublicTranslatorEntity>>getProfileTranslators();
  Future<List<PublicTranslatorEntity>>getProfileViewUpdates();
  Future<List<LocalEntity>>checkLocaleValidation();
}

class ProfileRemoteDataImpl implements ProfileRemoteData{
  final ProfileLocalData profileLocalData;
  final DioClientService dioClientService;

  ProfileRemoteDataImpl({required this.profileLocalData,required this.dioClientService});

  @override
  Future<List<PublicTranslatorEntity>> getProfileTranslators()async {
    final response=await dioClientService.getRequest('${ListApi.viewTranslators}13');
    final List objects=response.data;
    final objectsTomModel=objects.map<PublicTranslatorEntity>((e) {
      return PublicTranslatorEntity.fromJson(json: e);
    }).toList();
    if(objectsTomModel.isNotEmpty)await profileLocalData.setProfileTranslators(models: objectsTomModel);
    return objectsTomModel;
  }

  @override
  Future<List<PublicTranslatorEntity>> getProfileViewUpdates()async {
    final response=await dioClientService.getRequest('${ListApi.viewTransUpdates}13');
    final List objects=response.data;
    final objectsToModel=objects.map<PublicTranslatorEntity>((e) =>PublicTranslatorEntity.fromJson(json: e)).toList();
    return objectsToModel;
  }

  @override
  Future<List<LocalEntity>> checkLocaleValidation()async {
    final response=await dioClientService.getRequest(ListApi.checkLang);
    final List objects=response.data;
    final objectsToModels=objects.map((e) => LocalEntity.fromJson(json: e)).toList();
    return objectsToModels;
  }

}