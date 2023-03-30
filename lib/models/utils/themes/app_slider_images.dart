import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';

import '../../../di/dependency_injection.dart';

class AppSliderImages{
  AppSliderImages(_);
  static List<String>getCarouseImages(){
    return sl<ThemeBloc>().appSliderImages.where((element) => element.imageKey=='carousel_image')
        .map<String>((e) => e.imageUrl!).toList();
  }

  static List<String>carouselImages=getCarouseImages();
}