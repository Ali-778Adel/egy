
import 'package:fl_egypt_trust/data/local_data_source/theme/them_local_data.dart';
import 'package:fl_egypt_trust/data/remote_data_source/theme/theme_remote_data.dart';
import 'package:fl_egypt_trust/models/entities/theme_enities/icons_entity.dart';
import 'package:fl_egypt_trust/models/entities/theme_enities/locale_entity.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/states.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/network_info.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../repository/networks/theme_repo/theme_network_repo.dart';
import '../../../entities/home_entities/home_translator_entity.dart';
import '../../../entities/theme_enities/colors_entity.dart';
import '../../language/languages.dart';
import 'events.dart';

class ThemeBloc extends Bloc<GetThemeEvent,ThemeStates>{
  final ThemeNetworkRepo themeNetworkRepo;

  List<ColorsEntity> colorsPalette=[];
  List<IconsEntity> appIcons=[];
  List<PublicTranslatorEntity>appGeneralTrans=[];
  List<IconsEntity>appSliderImages=[];
  String appLocal='';
  bool isThereUpdate=false;

  ThemeBloc({required this.themeNetworkRepo}) : super(ThemeStates()){

    on((event, emit)async{
      appLocal=await getNetworkLocal();
      print('app Local is $appLocal');
      emit(ThemeStates.copyWith(themeResponseStatus: ThemeResponseStatus.loading,message: 'loading ...'));
       try{
         // if(await sl<NetworkInfo>().isConnected){
         //   // List<LocalEntity>updates=await themeNetworkRepo.checkAppUpdates();
         //   // if(updates.first.val=="0"){
         //   //   appIcons = await themeNetworkRepo.getAppIcons();
         //   //   appSliderImages=await themeNetworkRepo.getAppSliderImages();
         //   //   colorsPalette=await themeNetworkRepo.getAppColors();
         //   //   appGeneralTrans=await themeNetworkRepo.getGeneralTrans(viewId: 14);
         //   // }else{
         //   //   isThereUpdate=true;
         //   //   appIcons=await sl<ThemeRemoteData>().getIcons();
         //   //   appSliderImages=await sl<ThemeRemoteData>().getAppSliderImages();
         //   //   colorsPalette=await sl<ThemeRemoteData>().getColors();
         //   //   appGeneralTrans=await sl<ThemeRemoteData>().getGeneralRemoteUpdatedTrans(viewId: 14);
         //   // }
         // }else{
         //
         // }
         appIcons = await themeNetworkRepo.getAppIcons();
         appSliderImages=await themeNetworkRepo.getAppSliderImages();
         colorsPalette=await themeNetworkRepo.getAppColors();
         appGeneralTrans=await themeNetworkRepo.getGeneralTrans(viewId: 14);
         emit(ThemeStates.copyWith(
           themeResponseStatus: ThemeResponseStatus.success,
           iconsEntity: appIcons,
           colorsEntity: colorsPalette,
           generalTranslatorsEntity: appGeneralTrans,
           appSliderImages: appSliderImages,
           // appLocal: appLocal,
           message: 'success'
         ));
         appIcons = await themeNetworkRepo.getUpdatedAppIcons();
         appSliderImages=await themeNetworkRepo.getUpdatedAppSliderImages();
         colorsPalette=await themeNetworkRepo.getUpdatedAppColors();
         appGeneralTrans=await themeNetworkRepo.getGeneralUpdatedTrans(viewId: 14);
         emit(ThemeStates.copyWith(
             themeResponseStatus: ThemeResponseStatus.success,
             iconsEntity: appIcons,
             colorsEntity: colorsPalette,
             generalTranslatorsEntity: appGeneralTrans,
             appSliderImages: appSliderImages,
             // appLocal: appLocal,
             message: 'success'
         ));



       }catch(e){
         emit(ThemeStates.copyWith(
           themeResponseStatus: ThemeResponseStatus.error,
           message: sl<DioErrorsImpl>().dioErrorMessage
         ));
       }

    });
  }
  Future<String> getNetworkLocal()async{
    String locale= (await sl<AppPreference>().getNetworkLocale()).networkLocalValue();
    if(locale.isNotEmpty){
      print('//////////////!!!!!!!!!!!!!!!$locale');
      return locale;
    }else{
      return EnumNetworkLangs.arabic.networkLocalValue();
    }
  }
}