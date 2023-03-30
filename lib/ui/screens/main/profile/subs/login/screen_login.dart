import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/activate_token/screen_activate_token_phone.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/password/reset/screen_reset_password_phone.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/active_token_view.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../../../../../../models/utils/themes/colors.dart';
import '../../../../widgets/custom_app_bar.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  _StateScreenLogin createState() => _StateScreenLogin();
}

class _StateScreenLogin extends State<ScreenLogin> {
  final TextEditingController _mobileController = TextEditingController(),
      _passwordController = TextEditingController();

  String? _errorNumber, _errorPassword;
  bool _showPassword = false;

  var localAuth = LocalAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkEasyLogin();
  }

  _checkEasyLogin() async {
    navigatorKey.currentContext?.read<AuthCubit>().state.isLoginLoading = false;
    navigatorKey.currentContext?.read<AuthCubit>().state.loginErrorMessage =
        null;

    MapEntry<String, String>? loginInfo =
        await AppPreference.instance.getLoginData();
    if (loginInfo != null) {
      try {
        bool didAuthenticate = await localAuth.authenticate(
            localizedReason: appLocalization.easyLoginMessage);
        if (didAuthenticate) {
          _mobileController.text = loginInfo.key;
          _passwordController.text = loginInfo.value;
          _login(loginInfo: loginInfo);
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          // Handle this exception here.
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(
                context: context,
                onPop: ()=>Navigator.pop(context),
                pageTitle: appLocalization.login.toUpperCase())
            .call(),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Transform.translate(
              //   offset: const Offset(100, -50),
              //   child: Transform.scale(
              //     scale: 1.5,
              //     child: SvgPicture.asset(
              //       'assets/drawable/ic_background.svg',
              //     ),
              //   ),
              // ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<AuthCubit, AuthCubitState>(
                      builder: (context, state) {
                    return IgnorePointer(
                      ignoring: state.isLoginLoading == true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ActivateTokenView(onActivateTokenTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenActivateTokenPhone()),
                            );
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _errorNumber = null;
                                  state.loginErrorMessage = null;
                                });
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: _mobileController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                errorText: _errorNumber,
                                labelText: appLocalization.mobileNumber,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: UiConstants
                                          .colorTextFieldEnabledUnderline),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _errorPassword = null;
                                  state.loginErrorMessage = null;
                                });
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              obscureText: _showPassword == false,
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                        state.loginErrorMessage = null;
                                      });
                                    },
                                    icon: Icon(_showPassword == false
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                errorText:
                                    _errorPassword ?? state.loginErrorMessage,
                                labelText: appLocalization.password,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: UiConstants
                                          .colorTextFieldEnabledUnderline),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenResetPasswordPhone()),
                              );
                            },
                            child: Text(
                              appLocalization.forgotPassword,
                              style:
                                  Theme.of(context).textTheme.button?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: UiConstants.colorPrimary,
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5),
                            child: Center(
                              child: TextButton(
                                onPressed: state.isLoginLoading == true
                                    ? null
                                    : () async {
                                        if ((await _validate()) == false)
                                          return;
                                        _login();
                                      },
                                child: state.isLoginLoading == true
                                    ? const SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white)))
                                    : Text(
                                        appLocalization.login.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(Size(
                                            state.isLoginLoading == true
                                                ? 45
                                                : double.infinity,
                                            45)),
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
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }

  Future<bool> _validate() async {
    _errorNumber = _mobileController.text.isEmpty == true
        ? appLocalization.errorEnterMobile
        : (_mobileController.text.length < 11 ||
                _mobileController.text.startsWith('01') == false
            ? appLocalization.errorEnterCorrectMobile
            : null);

    _errorPassword = _passwordController.text.isEmpty == true
        ? appLocalization.errorEnterPassword
        : null;

    setState(() {});
    return _errorPassword == null && _errorNumber == null;
  }

  _login({MapEntry<String, String>? loginInfo}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (loginInfo != null) {
      await context.read<AuthCubit>().login(
            userName: loginInfo.key,
            password: loginInfo.value,
          );
    } else {
      await context.read<AuthCubit>().login(
            userName: _mobileController.text,
            password: _passwordController.text,
          );
    }

    var state = context.read<AuthCubit>().state;

    if (state.userData != null) {
      _showSubmittingMessage(success: state.loginSuccessMessage);
    }
  }

  void _showSubmittingMessage({String? success}) async {
    await BottomSheetMessageNotification.show(context, label: success ?? '');
    if (success != null) {
      Navigator.of(context).pop();
    }
  }
}
