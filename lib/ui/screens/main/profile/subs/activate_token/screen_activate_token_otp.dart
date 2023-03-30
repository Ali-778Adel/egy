
import 'dart:async';

import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';

import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class ScreenActivateTokenOtp extends StatefulWidget {
  final String mobileNumber;


  const ScreenActivateTokenOtp({Key? key ,required this.mobileNumber}) : super(key: key);

  @override
  _StateScreenActivateTokenOtp createState() => _StateScreenActivateTokenOtp();
}

class _StateScreenActivateTokenOtp extends State<ScreenActivateTokenOtp> {
  static const double _verticalInputPadding = 10;

  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();


  String?   _errorOtp , _errorNewPassword , _errorConfirmPassword;
  bool  _showNewPassword = false , _showConfirmPassword = false;



  Timer? _timer;
  int _timeInSeconds = 60;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(appLocalization.activateTokenPin),
      ),
      body: BlocBuilder<AuthCubit, AuthCubitState>(
          builder: (context, state) {
          return IgnorePointer(
            ignoring: state.isLoginLoading == true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        appLocalization.enterOtpHint,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle
                        ),

                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2*_verticalInputPadding),
                      child: PinCodeTextField(
                        controller: _otpController,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        appContext: context,
                        length: 5,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          setState(() {
                            _errorOtp = null;
                          });
                        },
                        enablePinAutofill: true,
                        textStyle: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 30,
                          borderWidth: 3,
                          selectedColor: UiConstants.colorPrimary,
                          inactiveColor: UiConstants.colorTitle,
                        ),
                      ),
                    ),
                    Text(
                      _errorOtp ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: UiConstants.colorRed
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
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
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
                        obscureText: _showConfirmPassword == false,
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
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
                            _verify();
                          },
                          child: state.isLoginLoading == true
                              ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : Text(appLocalization.activateTokenPin.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
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
                                      side:  BorderSide(
                                          color: UiConstants.colorPrimary)))),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          appLocalization.donotGetOtp,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(

                              color: UiConstants.colorTitle
                          ),

                        ),

                        TextButton(
                          onPressed: _timeInSeconds == 0 ? (){
                            _resend();
                        } : null,
                          child: Text(
                              _timeInSeconds == 0 
                                  ? appLocalization.resend.toUpperCase()
                            : '00:${_timeInSeconds.toString().padLeft(2, '0')}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(

                              color: UiConstants.colorPrimary,
                            decoration: TextDecoration.underline
                          ),

                        ),)
                      ],
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





  _resend()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AuthCubit>().requestActivateToken(
      mobile: widget.mobileNumber,
    );

    _startTimer();

  }

  Future<bool> _validate()  async{



    _errorOtp = _otpController.text.length < 5 ?appLocalization.errorEnterOtp : null;
    _errorNewPassword = _newPasswordController.text.isEmpty == true ? appLocalization.errorEnterNewPassword : null;

    _errorConfirmPassword = _confirmPasswordController.text.isEmpty == true
        ? appLocalization.errorEnterConfirmPassword
        : (_confirmPasswordController.text != _newPasswordController.text ? appLocalization.errorMismatchPassword : null);



    setState(() {});
    return _errorOtp == null && _errorNewPassword == null && _errorConfirmPassword == null;
  }
  _verify()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AuthCubit>().activateToken(
      mobile: widget.mobileNumber,
      otp: _otpController.text,
      password: _newPasswordController.text
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

  void _startTimer() {
    _timeInSeconds = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if(mounted != true) return;
        setState(() {
          if (_timeInSeconds == 0) {
              timer.cancel();
          } else {
            _timeInSeconds--;
          }
        });
       
      },
    );
  }


}
