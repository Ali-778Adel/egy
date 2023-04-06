import 'package:fl_egypt_trust/data/services/network_info.dart';
import 'package:fl_egypt_trust/models/entities/home_entities/home_translator_entity.dart';

import '../../../data/local_data_source/theme/them_local_data.dart';
import '../../../data/remote_data_source/theme/theme_remote_data.dart';
import '../../../di/dependency_injection.dart';
import '../../../models/entities/theme_enities/colors_entity.dart';
import '../../../models/entities/theme_enities/icons_entity.dart';
import '../../../models/entities/theme_enities/locale_entity.dart';

class ThemeNetworkRepo{
  final ThemeLocalData themeLocalData;
  final ThemeRemoteData themeRemoteData;
  ThemeNetworkRepo({required this.themeLocalData,required this.themeRemoteData});

  Future<List<IconsEntity>>getAppIcons()async{
    try{
      final response=await themeLocalData.getLocalIcons();
      return response.fold((l)async =>await themeRemoteData.getIcons(receiveTimeOutInMillisecond: 15000) , (r) => r);
    }catch(e){
      throw(Exception);
    }
  }


  Future<List<IconsEntity>>getUpdatedAppIcons()async{
    try{
      final response=await themeRemoteData.getIcons();
      return response;
    }catch(e){
      final response=await themeLocalData.getLocalIcons();
      return response.fold((l)async =>await themeRemoteData.getIcons(receiveTimeOutInMillisecond: 15000) , (r) => r);
      throw(Exception);
    }
  }

  Future<List<IconsEntity>>getAppSliderImages()async{
    try{
      final response=await themeLocalData.getLocalSliderImages();
      return response.fold((l)async =>await themeRemoteData.getAppSliderImages(receiveTimeOutInMillisecond: 15000) , (r) => r);
      final nets=await themeRemoteData.getAppSliderImages(receiveTimeOutInMillisecond: 5000);
      return nets;
    }catch(e){
      throw(Exception);
    }
  }

  Future<List<IconsEntity>>getUpdatedAppSliderImages()async{
    try{
            final nets=await themeRemoteData.getAppSliderImages(receiveTimeOutInMillisecond: 5000);
            return nets;
    }catch(e){
      final response=await themeLocalData.getLocalSliderImages();
      return response.fold((l)async =>await themeRemoteData.getAppSliderImages(receiveTimeOutInMillisecond: 15000) , (r) => r);


    }
  }

  Future<List<ColorsEntity>>getAppColors()async{
    try{
      final response=await themeLocalData.getLocalColors();
      return response.fold((l)async => await themeRemoteData.getColors(receiveTimeOutInMillisecond: 15000), (r) => r);
      // final net=await themeRemoteData.getColors(receiveTimeOutInMillisecond: 5000);
      // return net;
    }catch(e){
      throw(Exception);

    }

  }

  Future<List<ColorsEntity>>getUpdatedAppColors()async{
    try{
            final net=await themeRemoteData.getColors(receiveTimeOutInMillisecond: 5000);
      return net;
    }catch(e){
      final response=await themeLocalData.getLocalColors();
      return response.fold((l)async => await themeRemoteData.getColors(receiveTimeOutInMillisecond: 15000), (r) => r);
    }

  }

  Future<List<PublicTranslatorEntity>>getGeneralTrans({required int viewId})async{
    final localData= await themeLocalData.getGeneralLocalTranslators();
    return localData.fold((l)async =>await themeRemoteData.getGeneralRemoteTrans(viewId: viewId,receiveTimeOutInMillisecond: 15000) , (r) {
      return r;
    } );
  }

  Future<List<PublicTranslatorEntity>>getGeneralUpdatedTrans({required int viewId})async{
   try{
     final data=await themeRemoteData.getGeneralRemoteUpdatedTrans(viewId: viewId,receiveTimeOutInMillisecond: 5000);
      if(data.isEmpty){
        return getGeneralTrans(viewId: viewId);
      }else{
        return await themeRemoteData.getGeneralRemoteTrans(viewId: viewId);
      }
   }catch(e){
     return  getGeneralTrans(viewId: viewId);
   }
}

Future<List<LocalEntity>>checkAppUpdates()async{
    return await themeRemoteData.checkAppUpdates();
}




}