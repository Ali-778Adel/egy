
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';
import 'package:fl_egypt_trust/models/entities/public_entities/order_model.dart';

import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/certification_documents.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_confirmation.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../../models/entities/public_entities/certification_type_model.dart';
import '../../../../../../models/utils/themes/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../redesign_home/pages/new_home_screen.dart';


class ScreenCertification extends StatefulWidget {

  OrderModel? orderModel;

   ScreenCertification({Key? key , this.orderModel}) : super(key: key);

  @override
  _StateScreenCertification createState() => _StateScreenCertification();
}

class _StateScreenCertification extends State<ScreenCertification> {
  static const double _verticalInputPadding = 10;

  final TextEditingController _nameController = TextEditingController(),
      _mobileController = TextEditingController(),
      _nationalIdController = TextEditingController();

  CertificationTypeModel? _selectedCertification;

  String? _errorName,
      _errorNumber,
      _errorNational,
      _errorCertification;

  final List<DocumentModel> documents = [DocumentModel()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorKey.currentContext?.read<CertificationCubit>().state.reset();
    initValues();
    _getCertificationsType();
  }

  initValues(){
    if(widget.orderModel == null) return;
    _nameController.text = widget.orderModel?.custName ?? '';
    _mobileController.text = widget.orderModel?.mobileNo ?? '';
    _nationalIdController.text = widget.orderModel?.natID ?? '';

  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as HomeScreenArgs;

    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async{
        _popup();
        return false;
      },
      child: Scaffold(
        appBar:CustomAppBar(
            context: context,
            pageTitle:args.issauanceCiretificationTxt,onPop:widget.orderModel==null? ()=>Navigator.pop(context):()async{_popup();
        return false;}).call(),
        body: BlocBuilder<CertificationCubit, CertificationCubitState>(
            builder: (context, state) {
              initIncomingValues(state);
            return IgnorePointer(
              ignoring: state.isSubmittingLoading == true,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            if (widget.orderModel?.orderRequestNo != null && widget.orderModel?.orderRequestNo?.isEmpty == false && widget.orderModel?.orderRequestNo != '0')
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2 * _verticalInputPadding),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  initialValue:  widget.orderModel?.orderRequestNo,
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Palette.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                                    labelText: appLocalization.orderNumber,
                                    fillColor:Palette.white,
                                    filled: true,
                                    disabledBorder:   OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Palette.black),
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: _verticalInputPadding),
                              child: TextFormField(
                                controller: _nameController,
                                onChanged: (value) {
                                  setState(() {
                                    _errorName = null;
                                  });
                                },
                                maxLength: 20,
                                textInputAction: TextInputAction.next,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  errorText: _errorName,
                                  labelText: appLocalization.name,
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
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _errorNumber = null;
                                });
                              },
                              controller: _mobileController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              maxLength: 14,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
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
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _errorNational = null;
                                });
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: _nationalIdController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              maxLength: 14,
                              enabled: widget.orderModel == null,
                              decoration: InputDecoration(
                                errorText: _errorNational,
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

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: _verticalInputPadding),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  DropdownButtonFormField<CertificationTypeModel>(
                                    // itemHeight: 50,
                                    isDense : false,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      // constraints: const BoxConstraints(
                                          // maxHeight: 70
                                      // ),
                                      errorText: _errorCertification,
                                      labelText: appLocalization.selectCertificationType,
                                      fillColor: UiConstants.colorTextFieldFill,
                                      filled: true,
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: UiConstants.colorRed),
                                      ),
                                      errorStyle: const TextStyle(
                                          color: UiConstants.colorRed),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: UiConstants
                                                .colorTextFieldEnabledUnderline),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: UiConstants
                                                .colorTextFieldEnabledUnderline
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                    value: _selectedCertification,

                                    items: state.certificationsTypes
                                        ?.map(
                                            (e) => DropdownMenuItem<CertificationTypeModel>(
                                          child: RowDropdown(
                                            label: e.certificateTypeName ?? '',
                                          ),
                                          value: e,
                                        ))
                                        .toList(),
                                    onChanged: (CertificationTypeModel? value) {
                                      setState(() {
                                        _selectedCertification = value;
                                        _errorCertification = null;
                                      });
                                    },
                                  ),
                                  if (state.isServicesLoading == true)
                                    const LinearProgressIndicator(
                                      minHeight: 2,
                                    ),
                                ],
                              ),
                            ),


                            if(_selectedCertification != null)
                              CertificationDocumentsView(
                                selectedCertification: _selectedCertification!,
                                documents: documents,
                                disableActions: state.isSubmittingLoading == true,
                                ),

                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: UiConstants.colorTextFieldFill,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                    child: Center(
                      child: TextButton(
                        onPressed: state.isSubmittingLoading == true
                            ? null
                            : ()async{
                          if((await _validate()) == false) return;
                          _submit();
                        },
                        child: state.isSubmittingLoading == true
                            ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                        : Text(widget.orderModel == null ? appLocalization.submit.toUpperCase() : appLocalization.editCertification.toUpperCase(),style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                 Size(state.isSubmittingLoading == true ? 45 : double.infinity, 45)),

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
              ),
            );
          }
        ),
      ),
    );
  }


  void initIncomingValues(CertificationCubitState state) {
    if(widget.orderModel == null) return;

    if(_selectedCertification == null && state.certificationsTypes != null && state.certificationsTypes?.isEmpty == false){
      _selectedCertification = state.certificationsTypes?.firstWhereOrNull((element) => element.certificateTypeID.toString()  == widget.orderModel?.certificateTypeID);
    }


  }


  _getCertificationsType() {
    setState(() {
      _errorCertification = null;
    });

    context.read<CertificationCubit>().getCertificationsList();
  }


  Future<bool> _validate()  async{
    _errorName = _nameController.text.isEmpty == true
        ? appLocalization.errorEnterName
        : null;
    _errorNumber = _mobileController.text.isEmpty == true
        ? appLocalization.errorEnterMobile
        : (_mobileController.text.length < 11 ||
                _mobileController.text.startsWith('01') == false
            ? appLocalization.errorEnterCorrectMobile
            : null);

    _errorNational = _nationalIdController.text.isEmpty == true
        ? appLocalization.errorEnterNationalId
        : (_nationalIdController.text.length < 14
            ? appLocalization.errorEnterCorrectNationalId
            : null);


    _errorCertification =
        _selectedCertification == null ? appLocalization.errorSelectService : null;

    bool docsHaveErrors = false;
    for(var doc in documents){
      if((await doc.isValidDoc()) == false){
        docsHaveErrors = true;
      }
    }

    setState(() {});
    return
    docsHaveErrors == false &&
      _errorName == null &&
        _errorNumber == null &&
        _errorNational == null &&
        _errorCertification == null;
  }

  _submit()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<CertificationCubit>().submit(
        custName: _nameController.text,
        mobileNo: _mobileController.text,
        natID: _nationalIdController.text,
        certificationType: _selectedCertification?.certificateTypeID ?? -1,
        documents: documents,
      orderRequestNo: widget.orderModel?.orderRequestNo
    );

    var state = context.read<CertificationCubit>().state;
    if(state.submittingSuccessMessage != null || state.submittingFailMessage != null){
      _showSubmittingMessage(success : state.submittingSuccessMessage, fail : state.submittingFailMessage);
    }

  }

  void _showSubmittingMessage({String? success, String? fail}) async{
    await BottomSheetMessageNotification.show(context, label: (success ?? fail) ?? '');
    if(success != null) {
      Navigator.of(context).pop();
    }
  }



  void _popup()async{
    FocusScope.of(context).requestFocus(FocusNode());
    if(_showDiscard() == true){
      await BottomSheetMessageConfirmation.show(
        context,
        initTime : 0,
        title: appLocalization.unsavedChangesTitle,
        message: appLocalization.unsavedChangesMessage,
        positiveText: appLocalization.discard,
        onPositiveTap: (){
          Navigator.of(context).pop();
        },
      );
      return;
    }
    Navigator.of(context).pop();
  }

  bool _showDiscard() {

    return _nameController.text.isNotEmpty == true
        || _mobileController.text.isNotEmpty == true
        || _nationalIdController.text.isNotEmpty == true
        || _selectedCertification != null;
  }

}
