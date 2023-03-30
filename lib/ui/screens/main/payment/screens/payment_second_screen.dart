import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/repository/common_function/handle_dio_error_excptions.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_third_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/states_drop_down.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/entities/payment_entities/Payment_second_Screen_model.dart';
import '../../../../../models/utils/themes/themes_bloc/bloc.dart';
import '../../../widgets/cities_drop_down.dart';
import '../../../widgets/connection_error widget.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../../widgets/subscribtion_drop_down.dart';
import '../bloc/payment_second_form_bloc/bloc.dart';
import '../bloc/payment_second_form_bloc/events.dart';
import '../bloc/payment_second_form_bloc/states.dart';

PaymentSecondScreenArgsModel paymentSecondScreenArgs =
    PaymentSecondScreenArgsModel();

class PaymentSecondFormScreen extends StatefulWidget {
  const PaymentSecondFormScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSecondFormScreen> createState() =>
      _PaymentSecondFormScreenState();
}

class _PaymentSecondFormScreenState extends State<PaymentSecondFormScreen> {
  final _formKey = GlobalKey<FormState>();

  PaymentStatesModel? selectedStateObject;
  PaymentCitiesModel? selectedCityObject;
  PaymentSubscriptionModel? selectSubscription;
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final addressController = TextEditingController();
  final nationalIdController = TextEditingController();
  final companyNameController = TextEditingController();
  final taxNumberController=TextEditingController();
  final subscriptionPeriodController = TextEditingController();
  final docStartDateController = TextEditingController();
  final docEndDateController = TextEditingController();
  final signatureNumberController = TextEditingController();
  final facebookMessageController = TextEditingController();
  final whatsappMessageController = TextEditingController();
  final authorizedNameController = TextEditingController();
  final authorizedPhoneController = TextEditingController();
  final authorizedNationalIdController = TextEditingController();

  double total=0;
  bool freeMissions = false;
  bool discountNotification = false;
  bool authorized = false;

  int subscriptionId=0;



  /// validate mostly all of the below fields
  String? checkVal({String? val, bool? condition, String? errorMessage}) {
    if (val == null || condition!) {
      return errorMessage;
    }
    return null;
  }

  /// validate doc start date field
  String? checkDocStartDateVal({String? val}) {
    if (val!.isEmpty) {
      return 'يجب ادخال تاريخ اصدار السجل';
    } else if (val.isNotEmpty) {

    } else {
      return null;
    }
    return null;
  }

  void saveScreenData({required int serviceId,required int serviceStatusId}) {
    paymentSecondScreenArgs = PaymentSecondScreenArgsModel(
        serviceId: serviceId,
        serviceStatusId: serviceStatusId,
        paymentStatesModel: selectedStateObject,
        paymentCitiesModel: selectedCityObject,
        paymentSubscriptionModel: selectSubscription,
        phoneNumber: phoneNumberController.text,
        userName: userNameController.text,
        address: addressController.text,
        emailAddress: emailAddressController.text,
        nationalId: nationalIdController.text,
        companyName: companyNameController.text,
        taxNumber: taxNumberController.text,
        subscriptionPeriod: subscriptionPeriodController.text,
        docStartDate: docStartDateController.text,
        docEndDate: docEndDateController.text,
        signatureNumber: signatureNumberController.text,
        facebookMessages: facebookMessageController.text,
        whatsAppMessages: whatsappMessageController.text,
        authorizedName: authorizedNameController.text,
        authorizedPhoneNumber: authorizedPhoneController.text,
        authorizedNationalId: authorizedNationalIdController.text,
        authorized: authorized,
        discountNotification: discountNotification,
        freeMissions: freeMissions,
        subscriptionId: subscriptionId,
        // total: total
    );
  }

  @override
  void initState() {
    super.initState();



    /// fetch selected data to ui after push screen inside widget tree agaain
    /// ** consider this happen inside one section
    /// *** i had to do that because user can navigate between form screen without losing his data
    //   selectSubscription = paymentSecondScreenArgs.paymentSubscriptionModel;
      selectedStateObject=paymentSecondScreenArgs.paymentStatesModel;
      selectedCityObject=paymentSecondScreenArgs.paymentCitiesModel;
      phoneNumberController.text = paymentSecondScreenArgs.phoneNumber ?? '';
      emailAddressController.text = paymentSecondScreenArgs.emailAddress ?? '';
      addressController.text = paymentSecondScreenArgs.address ?? '';
      nationalIdController.text = paymentSecondScreenArgs.nationalId ?? '';
      companyNameController.text = paymentSecondScreenArgs.companyName ?? '';
      taxNumberController.text=paymentSecondScreenArgs.taxNumber??'';
      subscriptionPeriodController.text =
          paymentSecondScreenArgs.subscriptionPeriod ?? '';
      docStartDateController.text = paymentSecondScreenArgs.docStartDate ?? '';
      docEndDateController.text = paymentSecondScreenArgs.docEndDate ?? '';
      signatureNumberController.text =
          paymentSecondScreenArgs.signatureNumber ?? '';
      facebookMessageController.text =
          paymentSecondScreenArgs.facebookMessages ?? '';
      whatsappMessageController.text =
          paymentSecondScreenArgs.whatsAppMessages ?? '';
      authorizedNameController.text =
          paymentSecondScreenArgs.authorizedName ?? '';
      authorizedPhoneController.text =
          paymentSecondScreenArgs.authorizedPhoneNumber ?? '';
      authorizedNationalIdController.text =
          paymentSecondScreenArgs.authorizedNationalId ?? '';
      authorized = paymentSecondScreenArgs.authorized ?? false;
      freeMissions = paymentSecondScreenArgs.freeMissions ?? false;
      discountNotification =
          paymentSecondScreenArgs.discountNotification ?? false;
      subscriptionId=paymentSecondScreenArgs.subscriptionId??0;

     if(selectedStateObject==null){
       BlocProvider.of<PaymentSecondFormStatesBloc>(context)
           .add(GetSecondFormStatesDataEvent());
     }


       BlocProvider.of<PaymentSecondFormSubscriptionsBloc>(context)
           .add(GetSecondFormSubscriptionsDataEvent(
           serviceId:paymentFirstScreenModel.serviceId));

  }


  String appLocal=sl<ThemeBloc>().appLocal;
  String getTrans({required  GetSecondFormStatesDataState state,required String txtKey}){
    if(appLocal=='ar-SA'){
      return "${state.publicTranslatorEntity!.where((element) => element.key == txtKey).first.val}";
    }else if(appLocal=='en-US'){
      return "${state.publicTranslatorEntity!.where((element) => element.key == txtKey).first.valEn}";
    }else{
      return "لا يوجد نص";
    }
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FirstScreenArgs;

    return Scaffold(
        appBar: CustomAppBar(context: context).call(),
        body: BlocConsumer<PaymentSecondFormStatesBloc,
            GetSecondFormStatesDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.message == 'loading...') {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.message == 'success') {
              return _buildBody(state, args);
            } else {
              return Center(
                child: RetryContainer(
                  onRetry: () {
                    BlocProvider.of<PaymentSecondFormStatesBloc>(context)
                        .add(GetSecondFormStatesDataEvent());
                  },
                  errorMessage: sl<DioErrorsImpl>().dioErrorMessage,
                ),
              );
            }
          },
        ));
  }

  Widget _buildBody(GetSecondFormStatesDataState stat, FirstScreenArgs args) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.sp),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// start form texts head
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 0.sp),
              child: Text(
                getTrans(state: stat, txtKey:'header1Txt'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold,height: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 8.sp),
              child: Text(
               getTrans(state: stat, txtKey: 'header2Txt'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 4.sp),
              child: Text(
                getTrans(state: stat, txtKey: 'header3Txt'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
              ),
            ),

            /// end of form texts heads

            ///first row contain state name and city name
            PaymentStatesDropDown(
              selectedStateObject: selectedStateObject,
              selectedCitiesModel: selectedCityObject,
              fieldHint:getTrans(state: stat, txtKey: 'governorateTxt'),
              onChanged: (val) {
                setState(() {
                  selectedStateObject = val;
                  selectedCityObject != null
                      ? selectedCityObject = null
                      : null;
                  BlocProvider.of<PaymentSecondFormCitiesBloc>(context)
                      .add(GetSecondFormCitiesDataEvent(
                          stateId: val.stateId!));
                });
              },
            ),
            PaymentCitiesDropDown(
              selectedCityObject: selectedCityObject,
              stateId: selectedStateObject == null
                  ? 4149
                  : selectedStateObject!.stateId,
              fieldHint: getTrans(state: stat, txtKey: 'cityTxt'),
              onChanged: (val) {
                setState(() {
                  selectedCityObject = val;
                });
              },
            ),

            /// second row contain mobile number and email address
            CustomTextField(
              maxLength: 11,
                textEditingController: phoneNumberController,
                textFieldTypes: TextFieldTypes.phone,
                labelHint:getTrans(state: stat, txtKey: 'mobileNumberTxt'),
                fieldHint:
                    ' ${AppGeneralTrans.enterTxt}'
                        ' ${getTrans(state: stat, txtKey: 'mobileNumberTxt')}',
                validator: (val) {
                  return checkVal(
                      val: val,
                      condition: val!.length != 11,
                      errorMessage: AppGeneralTrans.mobileValidationTxt);
                }),
            CustomTextField(
                textEditingController: emailAddressController,
                textFieldTypes: TextFieldTypes.email,
                labelHint:getTrans(state: stat, txtKey: 'emailTxt'),
                fieldHint:
                    ' ${AppGeneralTrans.enterTxt}'
                        ' ${getTrans(state: stat, txtKey: 'emailTxt')}',
                validator: (val) {
                  return checkVal(
                      val: val,
                      condition: !val!.contains('@'),
                      errorMessage: AppGeneralTrans.emailValidationTxt);
                }),

            /// third row contain address and national card number
            CustomTextField(
                textEditingController: addressController,
                textFieldTypes: TextFieldTypes.randomText,
                labelHint:getTrans(state: stat, txtKey: 'addressTxt'),
                fieldHint:
                    ' ${AppGeneralTrans.enterTxt}'
                        ' ${getTrans(state: stat, txtKey: 'addressTxt')}',
                validator: (val) {
                  return checkVal(
                      val: val,
                      condition: val!.isEmpty,
                      errorMessage: AppGeneralTrans.addressValidationTxt);
                }),
            CustomTextField(
              maxLength: 14,
                textEditingController: nationalIdController,
                textFieldTypes: TextFieldTypes.number,
                labelHint:getTrans(state: stat, txtKey: 'nationalIdTxt'),
                fieldHint:
                    ' ${AppGeneralTrans.enterTxt}'
                        ' ${getTrans(state: stat, txtKey: 'nationalIdTxt')}',
                validator: (val) {
                  return checkVal(
                      val: val,
                      condition: val!.length != 14,
                      errorMessage: AppGeneralTrans.nationalIdValidationTxt);
                }),

            ///  doc start date
            if (!args.isSignutre!)
              CustomDateTextField(
                textEditingController: docStartDateController,
                textFieldTypes: TextFieldTypes.date,
                labelHint:getTrans(state: stat, txtKey: 'docStartDate'),
                fieldHint:
                ' ${AppGeneralTrans.enterTxt}'
                    ' ${getTrans(state: stat, txtKey: 'docStartDate')}',
                validator: (val) {
                  return checkDocStartDateVal(val: val);
                },
              ),

            /// doc end date
            if (!args.isSignutre!)
              CustomDateTextField(
                textEditingController: docEndDateController,
                textFieldTypes: TextFieldTypes.date,
                labelHint:getTrans(state: stat, txtKey: 'docEndDate'),
                fieldHint:
                '${AppGeneralTrans.enterTxt}'
                    ' ${getTrans(state: stat, txtKey: 'docEndDate')}',
                validator: (val) {
                  return checkVal(
                      val: val,
                      condition: val!.isEmpty,
                      errorMessage: AppGeneralTrans.docEndDateValidationTxt);
                },
              ),

            /// row for company name
            if (!args.isSignutre!)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      textEditingController: companyNameController,
                      textFieldTypes: TextFieldTypes.randomText,
                      labelHint:getTrans(state: stat, txtKey: 'companyNameTxt'),
                      fieldHint:
                          ' ${AppGeneralTrans.enterTxt}'
                              ' ${getTrans(state: stat, txtKey: 'companyNameTxt')}',
                      validator: (val) {
                        return checkVal(
                            val: val,
                            condition: val!.isEmpty,
                            errorMessage: AppGeneralTrans.companyNameValidationTxt);
                      },
                    ),
                  ),
                ],
              ),

            /// row for taxt number
            if (!args.isSignutre!)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      maxLength: 9,
                      textEditingController: taxNumberController,
                      textFieldTypes: TextFieldTypes.number,
                      labelHint:'الرقم الضريبي',
                      fieldHint:
                      "ادخل الرقم الضريبي",
                      validator: (val) {
                        return checkVal(
                            val: val,
                            condition: val!.isEmpty,
                            errorMessage: AppGeneralTrans.companyNameValidationTxt);
                      },
                    ),
                  ),
                ],
              ),

            /// user name
            if (args.isSignutre!)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      textEditingController: companyNameController,
                      textFieldTypes: TextFieldTypes.randomText,
                      labelHint:getTrans(state: stat, txtKey: 'personNameTxt'),
                      fieldHint:
                          '${AppGeneralTrans.enterTxt}'
                              ' ${getTrans(state: stat, txtKey: 'personNameTxt')}',
                      validator: (val) {
                        return checkVal(
                            val: val,
                            condition: val!.isEmpty,
                            errorMessage:AppGeneralTrans.personNameTxt);
                      },
                    ),
                  ),
                ],
              ),

            /// row for service time
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: PaymentSubscriptionDropDown(
                      hint: ' ${getTrans(state: stat, txtKey: 'subsrcribtionPeriodTxt')}' ,
                      // selectedSubscriptionObject: selectSubscription,
                      serviceId: args.isSignutre! ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          selectSubscription = val;
                          subscriptionId=selectSubscription!.id!;
                          total=selectSubscription!.subPeriodCost!.toDouble();
                          print('total is $total');
                        });
                      },
                    )),
              ],
            ),
/// signatures count
            if (!args.isSignutre!)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      textEditingController: signatureNumberController,
                      textFieldTypes: TextFieldTypes.phone,
                      labelHint:getTrans(state: stat, txtKey: 'orderedSignaturesCounts'),
                      fieldHint:
                          ' ${AppGeneralTrans.enterTxt}'
                              ' ${getTrans(state: stat, txtKey: 'orderedSignaturesCounts')}',
                      validator: (val) {
                        return checkVal(
                            val: val,
                            condition: val!.isEmpty,
                            errorMessage: AppGeneralTrans.subscriptionCountValidationTxt);
                      },
                      onChanged: (val){
                        setState(() {
                          signatureNumberController.text=val;
                          total=double.parse('${
                              discountNotification?
                              signatureNumberController.text.isEmpty?

                              selectSubscription!.subPeriodCost! - selectSubscription!.discountCost! :
                              (selectSubscription!.subPeriodCost! - selectSubscription!.discountCost!)*int.parse(signatureNumberController.text)
                                  :

                              signatureNumberController.text.isEmpty ?
                              selectSubscription!.subPeriodCost :
                              (selectSubscription!.subPeriodCost)!*(int.parse(signatureNumberController.text))}');
                          print('total $total');
                        });
                      },
                    ),
                  ),
                ],
              ),

            /// row for check box
            if (!args.isSignutre!)
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                                child: Text(
                                  getTrans(state: stat, txtKey: 'freeProfessionsTxt'),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Checkbox(
                                  value: freeMissions,
                                  onChanged: (val) {
                                    setState(() {
                                      freeMissions = val!;
                                    });
                                  }),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                                child: Text(
                                  getTrans(state: stat, txtKey: 'discountNotificationTxt'),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Checkbox(
                                  value: discountNotification,
                                  onChanged: (val) {
                                    setState(() {
                                      discountNotification = val!;
                                      total=double.parse('${
                                          discountNotification?
                                          signatureNumberController.text.isEmpty?

                                          selectSubscription!.subPeriodCost! - selectSubscription!.discountCost! :
                                          (selectSubscription!.subPeriodCost! - selectSubscription!.discountCost!)*int.parse(signatureNumberController.text)
                                              :

                                          signatureNumberController.text.isEmpty ?
                                          selectSubscription!.subPeriodCost :
                                          (selectSubscription!.subPeriodCost)!*(int.parse(signatureNumberController.text))}');
                                      print('total $total');
                                    });
                                  }),
                            ],
                          )),
                        ],
                      ))
                ],
              ),

            if (selectSubscription != null)
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.sp,horizontal: 8.sp),
                    child: Text(
                      discountNotification ? getTrans(state: stat, txtKey: 'discountCostTxt'):getTrans(state: stat, txtKey: 'costTxt'),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text(
                    '${
                        discountNotification?
                        signatureNumberController.text.isEmpty?

                         selectSubscription!.subPeriodCost! - selectSubscription!.discountCost! :
                        (selectSubscription!.subPeriodCost! - selectSubscription!.discountCost!)*int.parse(signatureNumberController.text)
                            :

                        signatureNumberController.text.isEmpty ?
                        selectSubscription!.subPeriodCost :
                        (selectSubscription!.subPeriodCost)!*(int.parse(signatureNumberController.text))}',

                     style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Palette.colorRed),
                  )
                ],
              ),

            /// social messages
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12.sp),
                  child: Text(
                    getTrans(state: stat, txtKey: 'socialmediaMessagesTxt'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: Palette.mainBlue),
                  ),
                ),
                CustomTextField(
                  textEditingController: facebookMessageController,
                  textFieldTypes: TextFieldTypes.randomText,
                  labelHint:getTrans(state: stat, txtKey: 'facebookMessageTxt'),
                  fieldHint:
                      '${AppGeneralTrans.enterTxt}'
                          ' ${getTrans(state: stat, txtKey: 'facebookMessageTxt')}',
                ),
                CustomTextField(
                  textEditingController: whatsappMessageController,
                  textFieldTypes: TextFieldTypes.randomText,
                  labelHint:getTrans(state: stat, txtKey:'whatsappMessageTxt'),
                  fieldHint:
                      '${AppGeneralTrans.enterTxt}'
                          ' ${getTrans(state: stat, txtKey:'whatsappMessageTxt')}',
                ),
              ],
            ),

            /// authorized check Box
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Text(
                    getTrans(state: stat, txtKey: 'comissionerTxt'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Palette.mainBlue, fontWeight: FontWeight.w600),
                  ),
                ),
                Checkbox(
                    value: authorized,
                    onChanged: (val) {
                      setState(() {
                        authorized = val!;
                      });
                    }),
              ],
            ),

            /// client data
            if (authorized)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    textEditingController: authorizedNameController,
                    textFieldTypes: TextFieldTypes.userName,
                    labelHint: getTrans(state: stat, txtKey: 'comissionerNameTxt'),
                    fieldHint:
                        ' ${AppGeneralTrans.enterTxt}'
                            ' ${getTrans(state: stat, txtKey: 'comissionerNameTxt')}',
                    validator: (val) {
                      return checkVal(
                          val: val, condition: val!.isEmpty, errorMessage: AppGeneralTrans.commissionerNameValidationTxt);
                    },
                  ),
                  CustomTextField(
                    maxLength: 11,
                      textEditingController: authorizedPhoneController,
                      textFieldTypes: TextFieldTypes.phone,
                      labelHint: getTrans(state: stat, txtKey: 'comissionerphoneTxt'),
                      fieldHint:
                          '${AppGeneralTrans.enterTxt}'
                              ' ${getTrans(state: stat, txtKey: 'comissionerphoneTxt')}',
                      validator: (val) {
                        return checkVal(
                            val: val,
                            condition: val!.length != 11,
                            errorMessage:AppGeneralTrans.commissionerMobileValidationTxt);
                      }),
                  CustomTextField(
                    maxLength: 14,
                    textEditingController: authorizedNationalIdController,
                    textFieldTypes: TextFieldTypes.number,
                    labelHint: getTrans(state: stat, txtKey: 'comissionerNationalIdTxt'),
                    fieldHint:
                        '${AppGeneralTrans.enterTxt}'
                            ' ${getTrans(state: stat, txtKey: 'comissionerNationalIdTxt')}',
                    validator: (val) {
                      return checkVal(
                          val: val,
                          condition: val!.length != 14,
                          errorMessage: AppGeneralTrans.commissionerNationalIdValidationTxt);
                    },
                  ),
                ],
              ),

            /// next pervious buttons
            Row(
              children: [
                Expanded(flex: 1
                  ,child:  CustomMediumButton(
                      buttonText: AppGeneralTrans.perviousButtomTxt,
                      onTap: () {
                        saveScreenData(serviceId: args.serviceId!,serviceStatusId: args.serviceStatusId!);
                        selectSubscription=null;
                        Navigator.pop(context);
                      },
                    ),),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  flex: 1,
                  child: CustomMediumButton(
                    buttonText: AppGeneralTrans.nextButtomTxt,
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate() &&
                          selectedCityObject != null &&
                          selectedStateObject != null) {
                        saveScreenData(serviceId: args.serviceId!,serviceStatusId: args.serviceStatusId!);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentThirdScreen(),
                              settings: RouteSettings(arguments: args)),
                        );
                      } else {
                        showToastWidget( CustomToastWidget(
                          toastStatus: ToastStatus.error,
                          toastContent:AppGeneralTrans.dataRequirementValidationTxt,
                        ),position: ToastPosition.bottom);
                      }
                    },
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
