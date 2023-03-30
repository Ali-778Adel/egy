import 'package:dartz/dartz.dart';

import '../../../models/entities/home_entities/home_translator_entity.dart';
import '../../local_data_source/home/home_local_data.dart';
import '../../services/dio/dio_client.dart';
import '../../services/dio/list_api.dart';

abstract class HomeRemoteData{
  Future<List<PublicTranslatorEntity>>getHomeTranslators({required int viewId});
  Future<List<PublicTranslatorEntity>>getHomeViewUpdates({required int viewId});
}

class HomeRemoteDataImpl implements HomeRemoteData{
  final HomeLocalData homeLocalData;
  final DioClientService dioClientService;

  HomeRemoteDataImpl({required this.homeLocalData,required this.dioClientService});



  @override
  Future<List<PublicTranslatorEntity>> getHomeTranslators({required int viewId})async {
    final response=await dioClientService.getRequest('${ListApi.viewTranslators}$viewId');
    final List objects=response.data;
    final objectsTomModel=objects.map<PublicTranslatorEntity>((e) {
      return PublicTranslatorEntity.fromJson(json: e);
    }).toList();
    if(objectsTomModel.isNotEmpty)await homeLocalData.setHomeTranslators(models: objectsTomModel,viewId: viewId);
    return objectsTomModel;
  }

  @override
  Future<List<PublicTranslatorEntity>> getHomeViewUpdates({required int viewId})async {
    final response=await dioClientService.getRequest('${ListApi.viewTransUpdates}$viewId');
    final List objects=response.data;
    final objectsToModel=objects.map<PublicTranslatorEntity>((e) =>PublicTranslatorEntity.fromJson(json: e)).toList();
    return objectsToModel;
  }



}