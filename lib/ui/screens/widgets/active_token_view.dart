import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/activate_token/screen_activate_token_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivateTokenView extends StatelessWidget {
  final VoidCallback? onActivateTokenTap;

  const ActivateTokenView({Key? key, this.onActivateTokenTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<AuthCubit, AuthCubitState>(builder: (context, state) {
      if (state.userData == null) {
        return Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appLocalization.newInEgyptTrust,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: UiConstants.colorTitle),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  appLocalization.newInEgyptTrustHint,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                       color: UiConstants.colorHint),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Center(
                    child: TextButton(
                      onPressed: onActivateTokenTap ??
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenActivateTokenPhone()),
                            );
                          },
                      child: Text(
                          appLocalization.activateTokenPin.toUpperCase(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 45)),

                          backgroundColor: MaterialStateProperty.all<Color>(
                              Palette.mainGreen),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                  side:  BorderSide(
                                      color: Palette.mainGreen)))),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
      return Container(
        height: 1,
      );

      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Text(
      //       appLocalization.welcome,
      //       style: Theme.of(context).textTheme.headline4?.copyWith(
      //           fontWeight: FontWeight.bold,
      //           color: UiConstants.colorPrimary),
      //     ),
      //     Text(
      //       state.userData?.userFullName?.toUpperCase() ?? '',
      //       style: Theme.of(context).textTheme.bodyText1?.copyWith(
      //           fontWeight: FontWeight.bold,
      //           color: UiConstants.colorTitle),
      //     ),
      //   ],
      // );
    });
  }
}
