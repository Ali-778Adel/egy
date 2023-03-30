


import 'dart:async';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../models/utils/themes/colors.dart';

class BottomSheetRevokeCertificationOtp extends StatefulWidget {
  final String title;
  final String certificationSerial;

  const BottomSheetRevokeCertificationOtp({Key? key,
    required this.title,
    required this.certificationSerial,
  }) : super(key: key);


  static Future<MapEntry<bool , String>?> show(BuildContext context,
      {required String title , required String certificationSerial}) async {
    return await showModalBottomSheet<MapEntry<bool , String>>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return BottomSheetRevokeCertificationOtp(
          title: title,
          certificationSerial: certificationSerial,
        );
      },
    );

  }

  @override
  _StateBottomSheetRevokeCertificationOtp createState() => _StateBottomSheetRevokeCertificationOtp();
}

  class _StateBottomSheetRevokeCertificationOtp extends State<BottomSheetRevokeCertificationOtp>{
    String? _errorOtp;

    final _otpController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding :  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<CertificationActionsCubit, CertificationActionsCubitState>(
          builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Text(
                 appLocalization.revokeCertificationOtpMessage,

                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: UiConstants.colorTitle),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PinCodeTextField(
                  controller: _otpController,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  appContext: context,
                  length: 5,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    setState(() {
                      _errorOtp = null;
                      state.actionFailMessage = null;
                    });
                  },
                  enablePinAutofill: true,
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 35),
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
              Center(
                child: Text(
                  state.actionFailMessage ?? _errorOtp ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: UiConstants.colorRed
                  ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0 , horizontal: 20),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        appLocalization.back.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(const Size(
                              double.infinity, 45)),

                          backgroundColor: MaterialStateProperty.all<Color>(
                              UiConstants.colorPrimary),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side:  BorderSide(
                                      color: UiConstants.colorPrimary)))),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(

                    flex: 1,
                    child: Container(
                      child: Center(
                        child: TextButton(

                          onPressed: state.isRevokeActionLoading == true
                              ? null
                              : ()async{
                            if((await _validate()) == false) return;
                            _revokeCertification();
                          },
                          child: state.isRevokeActionLoading == true
                              ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : Text(appLocalization.revokeCertification.toUpperCase(),style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(state.isRevokeActionLoading == true ? 45 : double.infinity, 45)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  UiConstants.colorRed),
                              foregroundColor:
                              MaterialStateProperty.all<Color>(UiConstants
                                  .colorTitle),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: const BorderSide(
                                          color: UiConstants.colorRed)))),
                        ),
                      ),
                    ),
                  ),

                ],),
              ),

            ],
          );
        }
      ),
    );
  }


    Future<bool> _validate()  async{
      _errorOtp = _otpController.text.length < 5 ?appLocalization.errorEnterOtp : null;

      setState(() {});
      return _errorOtp == null ;
    }

    _revokeCertification()async{
      FocusScope.of(context).requestFocus(FocusNode());
      await context.read<CertificationActionsCubit>().revokeCertification(
          certificationSerial: widget.certificationSerial ,
          otp: _otpController.text,
      );
      var state = context.read<CertificationActionsCubit>().state;
      if(state.actionSuccessMessage != null){
        _showSubmittingMessage(success : state.actionSuccessMessage);
      }
    }

    void _showSubmittingMessage({String? success}) async{
      Navigator.of(context).pop(MapEntry(true, success));
    }

}
