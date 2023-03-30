import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/active_certifications/my_certifications_view.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/utils/themes/colors.dart';
import '../../widgets/custom_app_bar.dart';

class ScreenActiveCertification extends StatefulWidget {
  const ScreenActiveCertification({Key? key}) : super(key: key);

  @override
  _StateScreenActiveCertification createState() =>
      _StateScreenActiveCertification();
}

class _StateScreenActiveCertification extends State<ScreenActiveCertification> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:CustomAppBar(context:context).call(),
        body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Transform.translate(
          //   offset: const Offset(100, -50),
          //   // child: Transform.scale(
          //   //   scale: 1.5,
          //   //   child: SvgPicture.asset(
          //   //
          //   //     'assets/drawable/ic_background.svg',
          //   //     color: UiConstants.colorOrange,
          //   //   ),
          //   // ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Text(
                //     appLocalization.myActiveCertification.toUpperCase(),
                //     style: Theme.of(context).textTheme.headline6?.copyWith(
                //         fontWeight: FontWeight.bold,
                //         color: UiConstants.colorPrimary),
                //   ),
                // ),
                  Expanded(
                  child: Center(
                    child: BlocBuilder<AuthCubit, AuthCubitState>(
                        builder: (context, state) {
                          if(state.userData == null) {
                            return _NotAuthorizedView(onLoginTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ScreenLogin()),
                              );
                            });
                          }
                        return const ActiveCertificationsView();
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _NotAuthorizedView extends StatelessWidget {
  final VoidCallback? onLoginTap;

  const _NotAuthorizedView({required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appLocalization.activeCertificationsPreLoginMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: UiConstants.colorTitle),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
              onPressed: onLoginTap,
              child: Text(appLocalization.login.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 45)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      Palette.mainGreen),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side:  BorderSide(
                              color: Palette.mainGreen)))),
            ),
          )
        ],
      ),
    );
  }


}
