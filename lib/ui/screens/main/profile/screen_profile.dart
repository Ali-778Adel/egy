import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_egypt_trust/data/services/network_info.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/settings_bloc/cubit_seetings_bloc.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/events.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/models/utils/utilities.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/login/screen_login.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/password/screen_change_password.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/active_token_view.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_confirmation.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../main_directional_widget.dart';
import '../../../../models/entities/theme_enities/locale_entity.dart';
import '../../../../models/utils/themes/app_icons.dart';
import '../../../../repository/networks/profile_repo/profile_network_repo.dart';
import '../../widgets/connection_error widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../branches/screens/branches_screen.dart';
import 'bloc/bloc.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  _StateScreenProfile createState() => _StateScreenProfile();
}

class _StateScreenProfile extends State<ScreenProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileTransBloc>(context).add(ProfileTransEvent());
  }
  String appLocal=sl<ThemeBloc>().appLocal;
  String getTrans({required  ProfileTransStates snapshot,required String txtKey}){
    if(appLocal=='ar-SA'){
      return "${snapshot.transEntities!.where((element) => element.key == txtKey).first.val}";
    }else if(appLocal=='en-US'){
      return "${snapshot.transEntities!.where((element) => element.key == txtKey).first.valEn}";
    }else{
      return "لا يوجد نص";
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthCubit,AuthCubitState>(
        builder: (context, state) {
        return BlocBuilder<ProfileTransBloc,ProfileTransStates>(
          builder: (context, snapshot) {
            switch(snapshot.profileViewResponseStatus){
              case ProfileViewResponseStatus.loading:{
                return const Center(child: CircularProgressIndicator(),);
              }
              case ProfileViewResponseStatus.error:{
                return RetryContainer(
                  onRetry: (){
                    BlocProvider.of<ProfileTransBloc>(context).add(ProfileTransEvent());
                  },
                  errorMessage: '${snapshot.message}',);
              }
              case ProfileViewResponseStatus.success:{
                return Scaffold(
                    appBar: CustomAppBar(context:context).call(),
                    body: SafeArea(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: state.userData != null ? 30 : 0),
                                    child: const ActivateTokenView(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildSection(
                                    label: getTrans(snapshot: snapshot, txtKey: 'contactsTxt'),
                                    children: [
                                      _buildAction(
                                          icon: AppIcons.callUsIcon,
                                          title: getTrans(snapshot: snapshot, txtKey: 'contactUsTxt'),
                                          hint: getTrans(snapshot: snapshot, txtKey: 'contactUsInfoTxt'),
                                          onTap: ()async{
                                            String phone = 'tel:19877';
                                            if((await canLaunch(phone)) == true) {
                                              launch(phone);
                                            }
                                          }
                                      ),

                                      _buildAction(
                                          icon: AppIcons.messageUsIcon,
                                          title: getTrans(snapshot: snapshot, txtKey: 'messageUsTxt'),
                                          hint: getTrans(snapshot: snapshot, txtKey: 'messageUsInfoTxt'),
                                          onTap: (){
                                            String phone = '+201000759637';

                                            Utilities.openWhatsApp(context, phone , whatsAppNotInstalled: appLocalization.whatsAppNotInstalledMessage);
                                          }
                                      ),

                                      _buildAction(
                                          icon: AppIcons.branchesIcon,
                                          title:getTrans(snapshot: snapshot, txtKey: 'branchesTxt'),
                                          hint:getTrans(snapshot: snapshot, txtKey:'branchesInfoTxt'),
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const BranchesScreen()),
                                            );
                                          }
                                      ),
                                    ],
                                  ),


                                  const SizedBox(
                                    height: 20,
                                  ),


                                  _buildSection(
                                    label:getTrans(snapshot: snapshot, txtKey: 'settingsTxt'),
                                    children: [
                                      FutureBuilder(
                                          future: sl<ProfileNetworkRepo>().checkLanValidation(),
                                          builder: (context,AsyncSnapshot <List<LocalEntity>>snap){

                                            return  _buildAction(
                                                icon: AppIcons.changeLangIcon,
                                                title: getTrans(snapshot: snapshot, txtKey: 'changeLangTxt'),
                                                hint:getTrans(snapshot: snapshot, txtKey: 'changeLangArTxt'),
                                                onTap: ()async{
                                                  if(snap.connectionState==ConnectionState.waiting){
                                                    showCupertinoModalPopup(
                                                        context: context, builder: (context){
                                                      return Center(
                                                        child: Container(
                                                          height: 160.sp,
                                                          width: 60.w,
                                                          decoration:  BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                                        color: Palette.white,
                                                        boxShadow: [
                                                        BoxShadow(color: Palette.textHint,blurRadius: 4,spreadRadius: 5)
                                                        ]
                                                        ),
                                                          child:const Center(
                                                           child: CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                      );
                                                  }
                                                  else if(snap.hasError){
                                                    showCupertinoModalPopup(context: context, builder: (context){
                                                      return Center(
                                                        child: Container(
                                                            height: 160.sp,
                                                            width: 60.w,
                                                            decoration:  BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                                                color: Palette.white,
                                                                boxShadow: [
                                                                  BoxShadow(color: Palette.textHint,blurRadius: 4,spreadRadius: 5)
                                                                ]
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Center(child: Text(snap.error.toString(),style: Theme.of(context).textTheme.bodyMedium,),),
                                                                const Spacer(),
                                                                Center(
                                                                  child: Container(
                                                                    // height: 40.sp,
                                                                    width: 40.w
                                                                    ,child: TextButton(onPressed: (){
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                        style: ButtonStyle(

                                                                            backgroundColor:
                                                                            MaterialStateProperty.all<Color>(
                                                                                Palette.mainGreen),
                                                                            foregroundColor:
                                                                            MaterialStateProperty.all<Color>(
                                                                                Colors.white),
                                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                RoundedRectangleBorder(
                                                                                    borderRadius:
                                                                                    BorderRadius.circular(35.0),
                                                                                    side:
                                                                                    BorderSide(color: Palette.mainGreen)))),
                                                                        child: Center(child: Text("الغاء",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white,fontWeight: FontWeight.w600),),)),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                      );
                                                    });
                                                  }
                                                  else{
                                                    if(snap.data![0].val=='1'){
                                                      showCupertinoModalPopup(
                                                          context: context, builder: (context){
                                                        return Center(
                                                          child: SizedBox(
                                                            height: 160.sp,
                                                            width: 80.w,
                                                            child: Container(
                                                              padding: EdgeInsets.all(32.sp),
                                                                decoration:  BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                                                    color: Palette.white,
                                                                    boxShadow: [
                                                                      BoxShadow(color: Palette.textHint,blurRadius: 4,spreadRadius: 5)
                                                                    ]
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Center(child: Text('اللغة المتاحة حاليا هي اللغة العربية فقط .',style: Theme.of(context).textTheme.bodyMedium,),),
                                                                    const Spacer(),
                                                                    Container(
                                                                      width: 60.w,
                                                                      // height: 40.sp,
                                                                      padding: EdgeInsets.symmetric(vertical: 16.sp),
                                                                      child: TextButton(onPressed: (){
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                          style: ButtonStyle(
                                                                              backgroundColor:
                                                                              MaterialStateProperty.all<Color>(
                                                                                  Palette.mainGreen),
                                                                              foregroundColor:
                                                                              MaterialStateProperty.all<Color>(
                                                                                  Colors.white),
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                  RoundedRectangleBorder(
                                                                                      borderRadius:
                                                                                      BorderRadius.circular(35.0),
                                                                                      side:
                                                                                      BorderSide(color: Palette.mainGreen)))),
                                                                          child: Text("الغاء",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white,fontWeight: FontWeight.w600),)),
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    }else{
                                                      EnumNetworkLangs lang = await sl<AppPreference>().getNetworkLocale();
                                                      EnumNetworkLangs newLng = (lang == EnumNetworkLangs.arabic ? EnumNetworkLangs.english : EnumNetworkLangs.arabic);
                                                      await sl<AppPreference>().setNetworkLocale(newLng);
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(builder: (context)=>MainDirectionalWidget()),
                                                              (route) => false);
                                                      context.read<PrefSettingsModelCubit>().toggleLocale();
                                                    }
                                                  }
                                                  if(!await sl<NetworkInfo>().isConnected){
                                                    showToastWidget(CustomToastWidget(toastStatus: ToastStatus.warning,toastContent: "انت غير متصل بالانتر نت لا يمكنك تغيير اللغة ",),position: ToastPosition.center);

                                                  }

                                                  // Phoenix.rebirth(context);
                                                }
                                            );

                                          }),



                                      if(state.userData != null)
                                        _buildAction(
                                            icon: AppIcons.changePasswordIcon,
                                            title: getTrans(snapshot: snapshot, txtKey: 'changePasswordTxt'),
                                            hint:getTrans(snapshot: snapshot, txtKey:'changePasswordInfoTxt'),
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const ScreenChangePassword()),
                                              );
                                            }
                                        ),

                                      if(state.userData == null)
                                        _buildAction(
                                            icon: AppIcons.loginIcon,
                                            title: appLocalization.login,
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const ScreenLogin()),
                                              );
                                            }
                                        ),
                                      if(state.userData != null)
                                        _buildAction(
                                            icon: AppIcons.logOutIcon,
                                            title:getTrans(snapshot: snapshot, txtKey: 'logOutTxt'),
                                            onTap: (){
                                              _logout();

                                            }
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              default:{
                return Container();
              }
            }

          }
        );
      }
    );
  }

  _logout(){
     BottomSheetMessageConfirmation.show(
      context,
      initTime : 0,
      title: appLocalization.logout,
      message: appLocalization.logoutMessage,
      positiveText: appLocalization.logout,
      onPositiveTap: (){
        context.read<AuthCubit>().logout();
      },
    );
  }
  _buildSection({required String label, required List<Widget> children}) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10) ,),
      ),
      color:Palette.mainGreen,
      // UiConstants.colorCertificationCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,

                  color: UiConstants.colorTitle),
            ),
          ),
          ...children,
        ],
      ),
    );
  }


  _buildAction({required String icon ,required String title , String? hint ,required VoidCallback onTap}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5 , horizontal: 1),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
                minHeight: 60),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CachedNetworkImage(
                    imageUrl: icon,
                    height: 16.sp,
                    width: 16.sp,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>const Icon(Icons.error),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: UiConstants.colorTitle),
                          ),
                          if(hint?.isNotEmpty == true)
                            Text(
                              hint ?? '',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: UiConstants.colorHint),
                            ),
                        ],
                      ),
                    )
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.arrow_forward_ios , size: 16,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
