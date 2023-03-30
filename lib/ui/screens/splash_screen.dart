
import 'package:fl_egypt_trust/main_directional_widget.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/entities/public_entities/user_model.dart';

class ScreenSplash extends StatefulWidget {
  static String id = '/splash';

  const ScreenSplash({Key? key}) : super(key: key);

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();

    appLocalization = AppLocalizationsDelegate.instance();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        SvgPicture.asset('assets/drawable/ic_background.svg'),

        Padding(
          padding:  EdgeInsets.all(32.0.sp),
          child: Image.asset('assets/drawable/titleLogo.png'),
        ),

        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: SvgPicture.asset('assets/drawable/ic_powered_by.svg' ),
        // )
      ],
    ));
  }

  _getUserData() async {
    UserData? user = await AppPreference.instance.getUserData();

    if (user == null) {
      await Future.delayed(const Duration(seconds: 3));
    } else {
      await context.read<AuthCubit>().checkSession();
    }
    _getSystemOptions();
  }

  _getSystemOptions() async {
    /// stop_BottomSheet_ForceUpdate
    // var info = await PackageInfo.fromPlatform();
    // print('version : ${info.version}-${info.buildNumber}');
    // await context.read<SystemCubit>().systemOptions(
    //     iosVersion: Platform.isIOS ? info.version : null,
    //     androidVersion: Platform.isAndroid ? info.buildNumber : null);
    //
    // var state = context.read<SystemCubit>().state;
    // if (
    // state.isLoading != true && state.showUpdate == true
    // ) {
    //   print('updateMessage : ${state.isForceUpdate} , ${state.updateMessage}');
    //   await BottomSheetUpdateMessageConfirmation.show(context,
    //       message: state.updateMessage ?? '',
    //       canProceed: state.isForceUpdate == false);
    // }

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainDirectionalWidget()));
  }
}
