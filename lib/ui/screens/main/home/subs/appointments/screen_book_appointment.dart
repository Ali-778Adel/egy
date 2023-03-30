
import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/appointment/appointment_cubit_state.dart';

import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_confirmation.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../../../../../models/entities/public_entities/branch_available_time.dart';
import '../../../../../../models/entities/public_entities/branch_model.dart';
import '../../../../../../models/entities/public_entities/city_model.dart';
import '../../../../../../models/entities/public_entities/reservation_model.dart';
import '../../../../../../models/entities/public_entities/service_type.dart';

class ScreenBookAppointment extends StatefulWidget {
  final String? orderNumber;
  final ReservationModel? reservationModel;

  const ScreenBookAppointment({Key? key, this.orderNumber , this.reservationModel}) : super(key: key);

  @override
  _StateScreenBookAppointment createState() => _StateScreenBookAppointment();
}

class _StateScreenBookAppointment extends State<ScreenBookAppointment> {
  static const double _verticalInputPadding = 10;

  final TextEditingController _nameController = TextEditingController(),
      _mobileController = TextEditingController(),
      _nationalIdController = TextEditingController(),
      _dateController = TextEditingController();

  CityData? _selectedCity;
  BranchData? _selectedBranch;
  ServiceTypeData? _selectedService;
  BranchAvailableTimeData? _selectedVisitTime;
  DateTime? _selectedDate;

  String? _errorName,
      _errorNumber,
      _errorNational,
      _errorCity,
      _errorBranch,
      _errorService,
      _errorDate,
      _errorTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorKey.currentContext?.read<AppointmentCubit>().state.reset();
    initValues();
    _getAllCities();
  }

  initValues(){
    if(widget.reservationModel == null) return;
    _nameController.text = widget.reservationModel?.custName ?? '';
    _mobileController.text = widget.reservationModel?.mobileNo ?? '';
    _nationalIdController.text = widget.reservationModel?.natID ?? '';
    _selectedDate = DateFormat('yyyy/MM/dd').parse(widget.reservationModel?.dateTicket ?? '');
    _formatDate(resetError: false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async{
        _popup();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text(widget.reservationModel == null ? appLocalization.bookAppointment : appLocalization.editReservation),
        ),
        body: BlocBuilder<AppointmentCubit, AppointmentCubitState>(
            builder: (context, state) {
              initIncomingValues(state);
            return IgnorePointer(
              ignoring: state.isSubmittingLoading == true || state.isCancelLoading == true,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            if (widget.orderNumber != null || (widget.reservationModel?.orderRequestNo != null && widget.reservationModel?.orderRequestNo?.isEmpty == false && widget.reservationModel?.orderRequestNo != '0'))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2 * _verticalInputPadding),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  initialValue: widget.orderNumber ?? widget.reservationModel?.orderRequestNo,
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                      color: UiConstants.colorPrimary,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    labelStyle: Theme.of(context).textTheme.subtitle1,
                                    labelText: appLocalization.orderNumber,
                                    fillColor: UiConstants.colorTextFieldFill,
                                    filled: true,
                                    disabledBorder:  OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: UiConstants.colorPrimary),
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
                                textInputAction: TextInputAction.next,
                                maxLength: 20,
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
                              controller: _nationalIdController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              maxLength: 14,
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
                              padding: const EdgeInsets.only(
                                  bottom: _verticalInputPadding),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  DropdownButtonFormField<CityData>(

                                    isDense : false,
                                    isExpanded : true,
                                    decoration: InputDecoration(
                                      // constraints: const BoxConstraints(
                                      //   maxHeight: 70
                                      // ),

                                      errorText: _errorCity,
                                      labelText: appLocalization.selectCity,
                                      fillColor: UiConstants.colorTextFieldFill,
                                      filled: true,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: UiConstants
                                                .colorTextFieldEnabledUnderline),
                                      ),
                                    ),
                                    value: _selectedCity,
                                    items: state.allCities
                                        ?.map((e) => DropdownMenuItem<CityData>(
                                      child: RowDropdown(
                                        label: e.cityName ?? '',
                                      ),

                                      value: e,
                                    ))
                                        .toList(),
                                    onChanged: (CityData? value) {
                                      setState(() {
                                        _selectedCity = value;
                                        _errorCity = null;
                                        _selectedBranch = null;

                                        _getCityBranches(
                                            int.parse(value?.cityID ?? '-1'));
                                      });
                                    },
                                  ),
                                  if (state.isCitiesLoading == true)
                                    const LinearProgressIndicator(
                                      minHeight: 2,
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: _verticalInputPadding),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  DropdownButtonFormField<BranchData>(
                                    // itemHeight: 50,
                                    isDense : false,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      // constraints: const BoxConstraints(
                                      //     maxHeight: 70
                                      // ),


                                      errorText: _errorBranch,
                                      enabled: _selectedCity != null,
                                      labelText: appLocalization.selectBranch,
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
                                    value: _selectedBranch,
                                    items: state.cityBranches
                                        ?.map((e) => DropdownMenuItem<BranchData>(
                                      child: RowDropdown(
                                        label: e.branchName ?? '',
                                      ),
                                      value: e,
                                    ))
                                        .toList(),
                                    onChanged: (BranchData? value) {
                                      setState(() {
                                        _selectedBranch = value;
                                        _selectedService = null;
                                        _errorBranch = null;
                                        _getBranchServices(value?.branchID ?? -1);
                                        _getBranchAvailableTimes();
                                      });
                                    },
                                  ),
                                  if (state.isBranchesLoading == true)
                                    const LinearProgressIndicator(
                                      minHeight: 2,
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: _verticalInputPadding),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  DropdownButtonFormField<ServiceTypeData>(
                                    // itemHeight: 50,
                                    isDense : false,
                                    isExpanded : true,
                                    decoration: InputDecoration(
                                      // constraints: const BoxConstraints(
                                      //     maxHeight: 70
                                      // ),
                                      errorText: _errorService,
                                      enabled: _selectedBranch != null,
                                      labelText: appLocalization.selectServiceType,
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
                                    value: _selectedService,
                                    items: state.branchServices
                                        ?.map(
                                            (e) => DropdownMenuItem<ServiceTypeData>(
                                          child: RowDropdown(
                                            label: e.serviceTypeName ?? '',
                                          ),
                                          value: e,
                                        ))
                                        .toList(),
                                    onChanged: (ServiceTypeData? value) {
                                      setState(() {
                                        _selectedService = value;
                                        _errorService = null;
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: _verticalInputPadding),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _errorDate = null;
                                  });
                                },
                                controller: _dateController,
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  _showDatePicker();
                                },
                                readOnly: true,
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  errorText: _errorDate ??
                                      (state.availableTimeMessage?.isNotEmpty == true
                                          ? state.availableTimeMessage
                                          : null),
                                  suffixIcon: const Icon(Icons.date_range),
                                  labelText: appLocalization.pickupDate,
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
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  DropdownButtonFormField<BranchAvailableTimeData>(
                                    // itemHeight: 50,
                                    isDense : false,
                                    isExpanded: true,
                                    menuMaxHeight: 500,
                                    decoration: InputDecoration(
                                      // constraints: const BoxConstraints(
                                      //     maxHeight: 70
                                      // ),

                                      errorText: _errorTime,
                                      enabled:
                                      _dateController.text.isNotEmpty == true,
                                      labelText: appLocalization.selectVisitTime,
                                      fillColor: UiConstants.colorTextFieldFill,
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: UiConstants.colorRed),
                                      ),
                                      errorStyle: const TextStyle(
                                          color: UiConstants.colorRed),
                                      filled: true,
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
                                    value: _selectedVisitTime,
                                    items: state.branchAvailableTimes
                                        ?.map((e) =>
                                        DropdownMenuItem<BranchAvailableTimeData>(
                                          child: RowDropdown(
                                            label: e.aTime ?? '',
                                          ),
                                          value: e,
                                        ))
                                        .toList(),
                                    onChanged: (BranchAvailableTimeData? value) {
                                      setState(() {
                                        _errorTime = null;
                                        _selectedVisitTime = value;
                                      });
                                    },
                                  ),
                                  if (state.isAvailableTimesLoading == true)
                                    const LinearProgressIndicator(
                                      minHeight: 2,
                                    ),
                                ],
                              ),
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
                        onPressed:state.isSubmittingLoading == true
                            ? null
                            : (){
                          if(_validate() == false) return;
                          _submit();
                        },
                        child: state.isSubmittingLoading == true
                            ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                        : Text(widget.reservationModel == null ? appLocalization.reserve.toUpperCase() : appLocalization.editReservation.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                 Size(state.isSubmittingLoading == true ? 45 : double.infinity, 45)),

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
                  if(widget.reservationModel != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                    child: Center(
                      child: TextButton(
                        onPressed:state.isCancelLoading == true
                            ? null
                            : (){
                          _cancel();
                        },
                        child: state.isCancelLoading == true
                            ? const SizedBox(width: 35 , height: 35 ,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                            : Text(appLocalization.cancelReservation.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(state.isCancelLoading == true ? 45 : double.infinity, 45)),

                            backgroundColor: MaterialStateProperty.all<Color>(
                                UiConstants.colorRed),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(UiConstants.colorTitle),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: UiConstants.colorRed)))),
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



  _getAllCities() {
    setState(() {
      _errorCity = null;
    });

    context.read<AppointmentCubit>().getBranchesList(null);
  }

  _getCityBranches(int cityId , {bool resetError = true}) {
    if(resetError == true) {
      setState(() {
        _errorBranch = null;
      });
    }

    context.read<AppointmentCubit>().getBranchesList(cityId);
  }

  _getBranchServices(int branchId, {bool resetError = false}) {
   if(resetError == true) {
     setState(() {
       _errorService = null;
     });
   }

    context.read<AppointmentCubit>().getServicesList(branchId);
  }

  _getBranchAvailableTimes({bool resetError = true}) {
    if (_selectedBranch == null || _selectedDate == null) return;
    _selectedVisitTime = null;
    if(resetError == true) {
      setState(() {
        _errorTime = null;
      });
    }

    print(
        'branch : ${_selectedBranch?.branchID} , date : ${DateFormat('yyyy/MM/dd').format(_selectedDate ?? DateTime.now())}');
    context.read<AppointmentCubit>().getAvailableTimes(
        branchId: _selectedBranch?.branchID ?? -1,
        date: DateFormat('yyyy/MM/dd').format(_selectedDate ?? DateTime.now()));
  }

  void initIncomingValues(AppointmentCubitState state) {
    if(widget.reservationModel == null) return;
    if(_selectedCity == null && state.allCities != null && state.allCities?.isEmpty == false){
      _selectedCity = state.allCities?.firstWhereOrNull((element) => element.cityID  == widget.reservationModel?.cityID);
      if(_selectedCity != null) {
        _getCityBranches(int.parse(_selectedCity?.cityID ?? '-1') , resetError: false);
      }
    }

    if(_selectedBranch == null && state.cityBranches != null && state.cityBranches?.isEmpty == false){
      _selectedBranch = state.cityBranches?.firstWhereOrNull((element) => element.branchID.toString()  == widget.reservationModel?.branchID);
      if(_selectedBranch != null) {
        _getBranchAvailableTimes(resetError: false);
        _getBranchServices(_selectedBranch?.branchID ?? -1 , resetError: false);
        print('date is null : ${_selectedDate == null} ');
        print('branch : ${_selectedBranch?.branchID} , date : ${DateFormat('yyyy/MM/dd').format(_selectedDate ?? DateTime.now())}');

      }
    }
    if(_selectedService == null && state.branchServices != null && state.branchServices?.isEmpty == false){
      _selectedService = state.branchServices?.firstWhereOrNull((element) => element.serviceTypeID.toString()  == widget.reservationModel?.serviceTypeID);
    }
    if(_selectedVisitTime == null && state.branchAvailableTimes != null && state.branchAvailableTimes?.isEmpty == false){
      print('ticket time : ${widget.reservationModel?.timeTicket}');
      _selectedVisitTime = state.branchAvailableTimes?.firstWhereOrNull((element) => element.aTime  == widget.reservationModel?.timeTicket);
      if(_selectedVisitTime == null){
        _selectedVisitTime = BranchAvailableTimeData(aTime : widget.reservationModel?.timeTicket);
        state.branchAvailableTimes?.insert(0, _selectedVisitTime!);
      }
    }

  }



  _showDatePicker() async {
    _selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (_selectedDate != null) {
      _formatDate();
    }
  }
  _formatDate({bool resetError = true}){
    _dateController.text = DateFormat('dd MMM yyyy')
        .format(_selectedDate ?? DateTime.now())
        .toUpperCase();
    if(resetError == true) {
      setState(() {
        _errorDate = null;
      });
    }
    _getBranchAvailableTimes();
  }

  bool _validate()  {
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

    _errorCity = _selectedCity == null ? appLocalization.errorSelectCity : null;
    _errorBranch =
        _selectedBranch == null ? appLocalization.errorSelectBranch : null;
    _errorService =
        _selectedService == null ? appLocalization.errorSelectService : null;

    _errorDate = _dateController.text.isEmpty == true
        ? appLocalization.errorPickupDate
        : null;

    _errorTime = _selectedVisitTime == null
        ? appLocalization.errorSelectVisitTime
        : null;
    setState(() {});
    return _errorName == null &&
        _errorNumber == null &&
        _errorNational == null &&
        _errorCity == null &&
        _errorBranch == null &&
        _errorService == null &&
        _errorDate == null &&
        _errorTime == null;
  }

  _submit()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AppointmentCubit>().submitAppointment(
      custName: _nameController.text,
      mobileNo: _mobileController.text,
      natID: _nationalIdController.text,
      branchID: _selectedBranch?.branchID ?? -1 ,
      serviceTypeID: _selectedService?.serviceTypeID ?? -1,
      dateTicket: DateFormat('yyyy/MM/dd').format(_selectedDate ?? DateTime.now()),
      timeTicket: _selectedVisitTime?.aTime ?? '',
      orderRequestNo: widget.orderNumber ?? widget.reservationModel?.orderRequestNo,
      ticketID: widget.reservationModel?.ticketID
    );

    var state = context.read<AppointmentCubit>().state;
    if(state.submittingSuccessMessage != null || state.submittingFailMessage != null){
      _showSubmittingMessage(success : state.submittingSuccessMessage, fail : state.submittingFailMessage);
    }

  }


  _cancel()async{
    FocusScope.of(context).requestFocus(FocusNode());
    await context.read<AppointmentCubit>().deleteAppointment(
        custName: _nameController.text,
        mobileNo: _mobileController.text,
        natID: _nationalIdController.text,
        ticketID: widget.reservationModel?.ticketID
    );

    var state = context.read<AppointmentCubit>().state;
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
    || _selectedCity != null
    || _selectedBranch != null
    || _selectedService != null
    || _selectedDate != null
    || _selectedVisitTime != null;
  }

}

