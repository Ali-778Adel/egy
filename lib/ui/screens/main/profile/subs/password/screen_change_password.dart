
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


class ScreenChangePassword extends StatefulWidget {


  const ScreenChangePassword({Key? key}) : super(key: key);

  @override
  _StateScreenChangePassword createState() => _StateScreenChangePassword();
}

class _StateScreenChangePassword extends State<ScreenChangePassword> {
  static const double _verticalInputPadding = 10;

  final _oldPasswordController = TextEditingController(),
      _newPasswordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();


  String? _errorOldPassword , _errorNewPassword , _errorConfirmPassword;
  bool _showOldPassword = false, _showNewPassword = false , _showConfirmPassword = false;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(context: context,pageTitle: appLocalization.changePassword,onPop: ()=>Navigator.pop(context)).call(),
      body: BlocBuilder<AuthCubit, AuthCubitState>(
          builder: (context, state) {
          return IgnorePointer(
            ignoring: state.isLoginLoading == true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: _verticalInputPadding),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _errorOldPassword = null;
                            state.loginErrorMessage = null;
                          });
                        },
                        obscureText: _showOldPassword == false,
                        controller: _oldPasswordController,
                        maxLength: 20,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.colorRed),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              _showOldPassword = !_showOldPassword;
                              state.loginErrorMessage = null;
                            });
                          },
                              icon: Icon(_showOldPassword == false
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          errorText: _errorOldPassword,
                          labelText: appLocalization.password,
                          fillColor: UiConstants.colorTextFieldFill,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: _verticalInputPadding),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _errorNewPassword = null;
                            state.loginErrorMessage = null;
                          });
                        },
                        obscureText: _showNewPassword == false,
                        controller: _newPasswordController,
                        maxLength: 20,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.colorRed),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              _showNewPassword = !_showNewPassword;
                              state.loginErrorMessage = null;
                            });
                          },
                              icon: Icon(_showNewPassword == false
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          errorText: _errorNewPassword ,
                          labelText: appLocalization.newPassword,
                          fillColor: UiConstants.colorTextFieldFill,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: _verticalInputPadding),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _errorConfirmPassword = null;
                            state.loginErrorMessage = null;
                          });
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        obscureText: _showConfirmPassword == false,
                        controller: _confirmPasswordController,
                        maxLength: 20,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.colorRed),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                              state.loginErrorMessage = null;
                            });
                          },
                              icon: Icon(_showConfirmPassword == false
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          errorText: _errorConfirmPassword ,
                          labelText: appLocalization.confirmPassword,
                          fillColor: UiConstants.colorTextFieldFill,
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
                      child: Center(
                        child: TextButton(
                          onPressed: state.isLoginLoading == true
                              ? null
                              : ()async{
                            if((await _validate()) == false) return;
                            _changePassword(state.userData?.mobileNo ?? '');
                          },
                          child: state.isLoginLoading == true
                              ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : Text(appLocalization.changePassword.toUpperCase(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white,fontSize: 18),),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(state.isLoginLoading == true ? 45 : double.infinity, 45)),

                              backgroundColor: MaterialStateProperty.all<Color>(
                                  UiConstants.colorPrimary),
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side:  const BorderSide(
                                          color: UiConstants.colorPrimary)))),
                        ),
                      ),
                    )

                  ],
                )
              ),
            ),
          );
        }
      ),
    );
  }





  Future<bool> _validate()  async{


    _errorOldPassword = _oldPasswordController.text.isEmpty == true ? appLocalization.errorEnterCurrentPassword : null;

    _errorNewPassword = _newPasswordController.text.isEmpty == true ? appLocalization.errorEnterNewPassword : null;

    _errorConfirmPassword = _confirmPasswordController.text.isEmpty == true
        ? appLocalization.errorEnterConfirmPassword
        : (_confirmPasswordController.text != _newPasswordController.text ? appLocalization.errorMismatchPassword : null);



    setState(() {});
    return _errorOldPassword == null && _errorNewPassword == null && _errorConfirmPassword == null;
  }

  _changePassword(String userName)async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AuthCubit>().changePassword(
      userName: userName,
      currentPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    var state = context.read<AuthCubit>().state;
    if(state.loginSuccessMessage != null || state.loginErrorMessage != null){
      _showSubmittingMessage(success : state.loginSuccessMessage, fail : state.loginErrorMessage);
    }

  }

  void _showSubmittingMessage({String? success, String? fail}) async{
    await BottomSheetMessageNotification.show(context, label: (success ?? fail) ?? '');
    if(success != null) {
      await Future.delayed(const Duration(milliseconds: 200));
      Phoenix.rebirth(context);

      // Navigator.of(context).pop();
    }
  }



}
