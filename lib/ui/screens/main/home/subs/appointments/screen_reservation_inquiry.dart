
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';

import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/appointments/screen_book_appointment.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/certification_documents.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScreenReservationInquiry extends StatefulWidget {


  const ScreenReservationInquiry({Key? key}) : super(key: key);

  @override
  _StateScreenReservationInquiry createState() => _StateScreenReservationInquiry();
}

class _StateScreenReservationInquiry extends State<ScreenReservationInquiry> {
  static const double _verticalInputPadding = 10;

  final _nationalIdController = TextEditingController();


  String? _errorNational;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(appLocalization.reservationInquiry),
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentCubitState>(
          builder: (context, state) {
          return IgnorePointer(
            ignoring: state.isSearchLoading == true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        appLocalization.reservationInquiryMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle
                        ),

                      ),
                    ),


                    Padding(
                      padding:
                      const EdgeInsets.only(top: _verticalInputPadding),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _errorNational = null;
                            state.searchFailMessage = null;
                          });
                        },
                        controller: _nationalIdController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 14,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          errorText: _errorNational ?? state.searchFailMessage,
                          labelText: appLocalization.nationalId,
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
                          onPressed: state.isSearchLoading == true
                              ? null
                              : ()async{
                            if((await _validate()) == false) return;
                            _search();
                          },
                          child: state.isSearchLoading == true
                              ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : Text(appLocalization.search.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(state.isSearchLoading == true ? 45 : double.infinity, 45)),

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


    _errorNational = _nationalIdController.text.isEmpty == true
        ? appLocalization.errorEnterNationalId
        : (_nationalIdController.text.length < 14
            ? appLocalization.errorEnterCorrectNationalId
            : null);



    setState(() {});
    return _errorNational == null;
  }

  _search()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AppointmentCubit>().search(
      natId: _nationalIdController.text,
    );

    var state = context.read<AppointmentCubit>().state;
    if(state.reservationModel != null){

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ScreenBookAppointment(reservationModel: state.reservationModel,)),
      );
    }

  }




}
