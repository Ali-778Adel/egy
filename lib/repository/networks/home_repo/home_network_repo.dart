
import '../../../data/local_data_source/home/home_local_data.dart';
import '../../../data/remote_data_source/home/home_remote_data.dart';
import '../../../models/entities/home_entities/home_translator_entity.dart';

class HomeNetworkRepo{
  final HomeRemoteData homeRemoteData;
  final HomeLocalData homeLocalData;

  HomeNetworkRepo({required this.homeRemoteData,required this.homeLocalData});

  Future<List<PublicTranslatorEntity>>getHomeTranslators({required int viewId})async{
    final local =await homeLocalData.getHomeTranslators(viewId: viewId);
    return local.fold((l)async =>await homeRemoteData.getHomeTranslators(viewId: viewId), (r) => r);
  }

 Future<List<PublicTranslatorEntity>>getTransUpdates({required int viewId})async{
    try{
      final updates=await homeRemoteData.getHomeViewUpdates(viewId: viewId);
      if(updates.isEmpty){
        return getHomeTranslators(viewId: viewId);
      }else{
        return  await homeRemoteData.getHomeTranslators(viewId: viewId);
      }
    }catch(e){
      return getHomeTranslators(viewId: viewId);
    }

 }
}