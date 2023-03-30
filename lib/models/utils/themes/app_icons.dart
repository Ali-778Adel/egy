import 'package:fl_egypt_trust/models/entities/theme_enities/icons_entity.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';

import '../../../di/dependency_injection.dart';

class AppIcons{
  AppIcons(_);
 static String getIconsUrlsByKey(String key){
    return sl<ThemeBloc>().appIcons.where((element) => element.imageKey==key).first.imageUrl!;
  }



  static  String userIconUrl=getIconsUrlsByKey('manger_icon');
  static  String followOrdersImage=getIconsUrlsByKey('follow_order_image');
  static  String branchesIcon=getIconsUrlsByKey('branches_icon');
  static  String callUsIcon=getIconsUrlsByKey('call_us_icon');
  static  String issuanceCertificationIcon=getIconsUrlsByKey('issuance_certificate_icon');
  static  String bottomNavCertificationIcon=getIconsUrlsByKey('bottom_nav_certificate_icon');
  static  String messageUsIcon=getIconsUrlsByKey('messae_us_icon');
  static  String sealSignatureIcon=getIconsUrlsByKey('seal_signature_icon');
  static  String bottomNavHomeIcon=getIconsUrlsByKey('bottom_nav_home_icon');
  static  String changeLangIcon=getIconsUrlsByKey('cahnge_lang_icon');
  static  String logOutIcon=getIconsUrlsByKey('log_out_icon');
  static  String ordersQueryIcon=getIconsUrlsByKey('orders_query_icon');
  static  String changePasswordIcon=getIconsUrlsByKey('change_password_icon');
  static  String bottomNavUserIcon=getIconsUrlsByKey('bottom_nav_user_icon');
  static  String loginIcon=getIconsUrlsByKey('login_icon');


}