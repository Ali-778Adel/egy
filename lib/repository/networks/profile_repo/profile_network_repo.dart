import '../../../data/local_data_source/profile/profile_local_data.dart';
import '../../../data/remote_data_source/profile/profile_remote_data.dart';
import '../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../models/entities/theme_enities/locale_entity.dart';

class ProfileNetworkRepo{
  final ProfileRemoteData profileRemoteData;
  final ProfileLocalData profileLocalData;

  ProfileNetworkRepo({required this.profileRemoteData,required this.profileLocalData});

  Future<List<PublicTranslatorEntity>>getHomeTranslators()async{
    final local =await profileLocalData.geProfileTranslators();
    return local.fold((l)async =>await profileRemoteData.getProfileTranslators(), (r) => r);
  }

  Future<List<PublicTranslatorEntity>>getTransUpdates()async{
    try{
      final updates=await profileRemoteData.getProfileViewUpdates();
      if(updates.isEmpty){
        return getHomeTranslators();
      }else{
        return  await profileRemoteData.getProfileTranslators();
      }
    }catch(e){
      return getHomeTranslators();
    }

  }

  Future<List<LocalEntity>>checkLanValidation()async{
    return await profileRemoteData.checkLocaleValidation();
  }

}