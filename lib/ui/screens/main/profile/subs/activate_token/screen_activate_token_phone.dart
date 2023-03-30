
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/auth/auth_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';

import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/appointments/screen_book_appointment.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/certification_documents.dart';
import 'package:fl_egypt_trust/ui/screens/main/profile/subs/activate_token/screen_activate_token_otp.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/utils/themes/colors.dart';


class ScreenActivateTokenPhone extends StatefulWidget {


  const ScreenActivateTokenPhone({Key? key}) : super(key: key);

  @override
  _StateScreenActivateTokenPhone createState() => _StateScreenActivateTokenPhone();
}

class _StateScreenActivateTokenPhone extends State<ScreenActivateTokenPhone> {
  static const double _verticalInputPadding = 10;

  final _mobileController = TextEditingController();


  String? _errorNumber;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:CustomAppBar(context: context,pageTitle: '${AppGeneralTrans.actviateToken}',onPop: ()=>Navigator.pop(context)).call(),
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
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        appLocalization.enterMobileHint,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle
                        ),

                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: _verticalInputPadding),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _errorNumber = null;
                          });
                        },
                        style: Theme.of(context).textTheme.bodyMedium,

                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.colorRed),
                          errorText: _errorNumber,
                          labelText: appLocalization.mobileNumber,
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
                            _send();
                          },
                          child: state.isLoginLoading == true
                              ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : Text(appLocalization.next.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(state.isLoginLoading == true ? 45 : double.infinity, 45)),

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


    _errorNumber = _mobileController.text.isEmpty == true
        ? appLocalization.errorEnterMobile
        : (_mobileController.text.length < 11 ||
        _mobileController.text.startsWith('01') == false
        ? appLocalization.errorEnterCorrectMobile
        : null);



    setState(() {});
    return _errorNumber == null;
  }

  _send()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AuthCubit>().requestActivateToken(
      mobile: _mobileController.text,
    );
    var state = context.read<AuthCubit>().state;
    if(state.loginErrorMessage != null){
      _showSubmittingMessage(fail : state.loginErrorMessage);
    }else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ScreenActivateTokenOtp(mobileNumber: _mobileController.text,)),
      );
    }
  }


  void _showSubmittingMessage({ String? fail}) async{
    await BottomSheetMessageNotification.show(context, label: fail ?? '');
  }


}
