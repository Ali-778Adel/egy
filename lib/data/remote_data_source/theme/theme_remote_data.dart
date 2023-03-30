import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/data/local_data_source/theme/them_local_data.dart';
import 'package:fl_egypt_trust/data/services/dio/dio_client.dart';
import 'package:fl_egypt_trust/data/services/dio/list_api.dart';
import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/entities/theme_enities/colors_entity.dart';
import '../../../models/entities/theme_enities/icons_entity.dart';
import '../../../models/entities/theme_enities/locale_entity.dart';

abstract class ThemeRemoteData{
  Future<List<IconsEntity>>getIcons({int? receiveTimeOutInMillisecond});
  Future<List<IconsEntity>>getAppSliderImages({int? receiveTimeOutInMillisecond});
  Future<List<ColorsEntity>>getColors({int? receiveTimeOutInMillisecond});
  Future<List<PublicTranslatorEntity>>getGeneralRemoteTrans({required int viewId,int? receiveTimeOutInMillisecond});
  Future<List<PublicTranslatorEntity>> getGeneralRemoteUpdatedTrans({required int viewId,int? receiveTimeOutInMillisecond});
  Future<List<LocalEntity>>checkAppUpdates();
}


class ThemeRemoteDataImpl implements ThemeRemoteData{
  final DioClientService dioClientService;
  ThemeRemoteDataImpl({required this.dioClientService});

  @override
  Future<List<IconsEntity>> getIcons({int? receiveTimeOutInMillisecond})async {
    final response=await dioClientService.getRequest(ListApi.appIconsEndpoint,receiveTimeOutInMillisecond: receiveTimeOutInMillisecond);
    final List objects=response.data;
    final responseToModel=objects.map((e) => IconsEntity.fromJson(json: e)).toList();
    if(responseToModel.isNotEmpty)await sl<ThemeLocalData>().setLocalIcons(iconsModels: responseToModel);
    return responseToModel;
  }

  @override
  Future<List<IconsEntity>> getAppSliderImages({int? receiveTimeOutInMillisecond})async {
    final response=await dioClientService.getRequest(ListApi.appSliderImages,receiveTimeOutInMillisecond: receiveTimeOutInMillisecond);
    final List objects=response.data;
    final responseToModel=objects.map((e) => IconsEntity.fromJson(json: e)).toList();
    if(responseToModel.isNotEmpty)await sl<ThemeLocalData>().setLocalSliderImages(iconsModels: responseToModel);
    return responseToModel;
  }


  @override
  Future<List<ColorsEntity>> getColors({int? receiveTimeOutInMillisecond})async {
    final response=await dioClientService.getRequest(ListApi.appColorsEndpoint,receiveTimeOutInMillisecond: receiveTimeOutInMillisecond);
    final List objects=response.data;
    final responseToModel=objects.map((e) => ColorsEntity.fromJson(json: e)).toList();
    if(responseToModel.isNotEmpty) {
      await sl<ThemeLocalData>().setLocalColors(iconsModels: responseToModel).then((value) {
      print("theme localcolos cached successfully");
    });
    }
    return responseToModel;
  }




  @override
  Future<List<PublicTranslatorEntity>> getGeneralRemoteTrans({required int viewId,int? receiveTimeOutInMillisecond})async {
    final response=await dioClientService.getRequest('${ListApi.viewTranslators}$viewId',receiveTimeOutInMillisecond: receiveTimeOutInMillisecond);
    final List objects=response.data;
    final responseToModel=objects.map((e) => PublicTranslatorEntity.fromJson(json:e )).toList();
    if(responseToModel.isNotEmpty)await sl<ThemeLocalData>().setGeneralLocalTranslators(models: responseToModel, viewId: viewId);
    print('general trans cached success');
    return responseToModel;
  }

  @override
  Future<List<PublicTranslatorEntity>> getGeneralRemoteUpdatedTrans({required int viewId,int? receiveTimeOutInMillisecond})async {
    final response=await dioClientService.getRequest('${ListApi.viewTransUpdates}$viewId',receiveTimeOutInMillisecond: receiveTimeOutInMillisecond);
    final List objects=response.data;
    final responseToModel=objects.map((e) => PublicTranslatorEntity.fromJson(json:e )).toList();
    return responseToModel;
  }

  @override
  Future<List<LocalEntity>> checkAppUpdates()async {
    final response=await dioClientService.getRequest(ListApi.appUpdates);
    final List objects=response.data;
    final responseToModel=objects.map((e) => LocalEntity.fromJson(json: e)).toList();
    return responseToModel;

  }





}