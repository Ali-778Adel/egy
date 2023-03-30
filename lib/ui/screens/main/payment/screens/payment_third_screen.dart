import 'dart:io';
import 'dart:convert';

import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_second_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_summary_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/entities/payment_entities/payment_third_screen_model.dart';
import '../../../../../models/utils/themes/themes_bloc/bloc.dart';
import '../../../widgets/connection_error widget.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../../widgets/pickup_file_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/payment_third_form_bloc/bloc.dart';
import '../bloc/payment_third_form_bloc/events.dart';
import '../bloc/payment_third_form_bloc/states.dart';
import 'follow_order_screen.dart';

PaymentThirdScreenModel? paymentThirdScreenModel = PaymentThirdScreenModel();

class PaymentThirdScreen extends StatefulWidget {
  String issuanceOnePath = '';
  String? issuanceOneName = '';
  final _formKey = GlobalKey<FormState>();
  String fileName = '';
  String filePath = '';
  String taxCardName = '';
  String taxCardPath = '';
  String valueAddedCardName = '';
  String valueAddedCardPath = '';
  String issuanceRequestName = '';
  String issuanceRequestPath = '';
  String firstContractImageName = '';
  String firstContractImagePath = '';
  String secondContractImageName = '';
  String secondContractImagePath = '';
  String registerPersonCardName = '';
  String registerPersonCardPath = '';
  String nationalCardImageName = '';
  String nationalCardImagePath = '';
  String singleContractImageName = '';
  String singleContractImagePath = '';
  String commissionImageName = '';
  String commissionImagePath = '';
  String commissionerNationalCardImageName = '';
  String commissionerNationalCardImagePath = '';
  String?discountNotificationPath='';
  String?discountNotificationImageName='';


  PaymentThirdScreen({Key? key}) : super(key: key);

  @override
  State<PaymentThirdScreen> createState() => _PaymentThirdScreenState();
}

class _PaymentThirdScreenState extends State<PaymentThirdScreen> {
  @override
  void initState() {
    BlocProvider.of<PaymentThirdFormBloc>(context)
        .add(GetPaymentThirdFormBlocEvent());

    if (paymentThirdScreenModel != null) {
      widget.fileName = paymentThirdScreenModel!.pdfName ?? '';
      widget.filePath = paymentThirdScreenModel!.pdfPath ?? '';
      widget.taxCardName = paymentThirdScreenModel!.taxCard ?? '';
      widget.taxCardPath = paymentThirdScreenModel!.taxCardPath ?? '';
      widget.valueAddedCardName = paymentThirdScreenModel!.valueAddedCard ?? '';
      widget.valueAddedCardPath =
          paymentThirdScreenModel!.valueAddedCardPath ?? '';
      widget.issuanceRequestName =
          paymentThirdScreenModel!.issuanceRequest ?? '';
      widget.issuanceRequestPath =
          paymentThirdScreenModel!.issuanceRequestPath ?? '';
      widget.firstContractImageName =
          paymentThirdScreenModel!.firstContractImage ?? '';
      widget.firstContractImagePath =
          paymentThirdScreenModel!.firstContractImagePath ?? '';
      widget.secondContractImageName =
          paymentThirdScreenModel!.secondContractImage ?? '';
      widget.secondContractImagePath =
          paymentThirdScreenModel!.secondContractImagePath ?? '';
      widget.registerPersonCardName =
          paymentThirdScreenModel!.registerPersonCard ?? '';
      widget.registerPersonCardPath =
          paymentThirdScreenModel!.registerPersonCardPath ?? '';
      widget.commissionImageName =
          paymentThirdScreenModel!.commissionImageName ?? '';
      widget.commissionImagePath =
          paymentThirdScreenModel!.commissionImagePath ?? '';
      widget.commissionerNationalCardImageName =
          paymentThirdScreenModel!.commissionerNationalCardImageName ?? '';
      widget.commissionerNationalCardImagePath =
          paymentThirdScreenModel!.commissionerNationalCardImagePath ?? '';
    widget.discountNotificationPath=paymentThirdScreenModel!.discountNotificationPath??'';
    widget.discountNotificationImageName=paymentThirdScreenModel!.discountNotificationImageName??'';
    }

    super.initState();
  }


  String appLocal=sl<ThemeBloc>().appLocal;
  String getTrans({required  GetPaymentThirdFormDataStates state,required String txtKey}){
    if(appLocal=='ar-SA'){
      return "${state.publicTranslatorsEntity!.where((element) => element.key == txtKey).first.val}";
    }else if(appLocal=='en-US'){
      return "${state.publicTranslatorsEntity!.where((element) => element.key == txtKey).first.valEn}";
    }else{
      return "لا يوجد نص";
    }
  }
  @override
  Widget build(BuildContext context) {



    dynamic args = ModalRoute.of(context)!.settings.arguments as  FirstScreenArgs;



    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: BlocBuilder<PaymentThirdFormBloc, GetPaymentThirdFormDataStates>(
          builder: (context, state) {
        switch (state.paymentThirdFormResponseStatus) {
          case PaymentThirdFormResponseStatus.loading:
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          case PaymentThirdFormResponseStatus.success:
            {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.sp),
                child: Form(
                  key: widget._formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 16.sp),
                        child: Text(
                         getTrans(state: state, txtKey: 'header1Txt'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.sp, vertical: 8.sp),
                        child: Text(
                          getTrans(state: state, txtKey: 'header2Txt'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.sp, vertical: 8.sp),
                        child: Text(
                          getTrans(state: state, txtKey: 'header3Txt'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp),
                        ),
                      ),

                      /// pdf field
                      if (!args.isSignutre!&&!paymentSecondScreenArgs.freeMissions!)
                        PickUpFileField(
                          chooseButtonTtx: getTrans(state: state, txtKey: 'chooseFileTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'commerialRegisterTxt'),
                          fileName: widget.fileName,
                          onPickTapped: () {
                            pickFile();
                          },
                        ),

                      /// tax card
                      if (!args.isSignutre!)
                        PickUpFileField(
            chooseButtonTtx: getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel:getTrans(state: state, txtKey: 'taxCardTxt'),
                          fileName: widget.taxCardName,
                          onPickTapped: () {
                            pickSingleImage(0, args.isSignutre!);
                          },
                        ),

                      /// value added card
                      if (!args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),

                          fieldLabel: getTrans(state: state, txtKey: 'valueAddedCardTxt'),
                          fileName: widget.valueAddedCardName,
                          onPickTapped: () {
                            pickSingleImage(1, args.isSignutre!);
                          },
                        ),

                      /// issuance reques
                      PickUpFileField(
                        chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),

                        fieldLabel: getTrans(state: state, txtKey: 'issuanceRequestTxt'),
                        fileName: widget.issuanceRequestName,
                        onPickTapped: () {
                          pickSingleImage(
                              args.isSignutre! ? 0 : 2, args.isSignutre!);
                        },
                      ),

                      /// national card Image
                      if (args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),

                          fieldLabel: getTrans(state: state, txtKey:'nationalCardTxt'),
                          fileName: widget.nationalCardImageName,
                          onPickTapped: () {
                            pickSingleImage(1, args.isSignutre!);
                          },
                        ),

                      /// seal image
                      if (args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'contractImageTxt'),
                          fileName: widget.singleContractImageName,
                          onPickTapped: () {
                            pickSingleImage(2, args.isSignutre!);
                          },
                        ),

                      /// cntract first Image
                      if (!args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'firstContractTxt'),
                          fileName: widget.firstContractImageName,
                          onPickTapped: () {
                            pickSingleImage(3, args.isSignutre!);
                          },
                        ),

                      /// contract second Image
                      if (!args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'secondContractTxt'),
                          fileName: widget.secondContractImageName,
                          onPickTapped: () {
                            pickSingleImage(4, args.isSignutre!);
                          },
                        ),

                      /// rgister person right
                      if (!args.isSignutre!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'registrationRightCardTxt'),
                          fileName: widget.registerPersonCardName,
                          onPickTapped: () {
                            pickSingleImage(5, args.isSignutre!);
                          },
                        ),

                      if (paymentSecondScreenArgs.discountNotification!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel:getTrans(state: state, txtKey:'discountNotificationImageTxt'),
                          fileName: widget.discountNotificationImageName,
                          onPickTapped: () {
                            pickSingleImage(6, args.isSignutre!);
                          },
                        ),


                      /// commission Image
                      if (paymentSecondScreenArgs.authorized!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'comissionImageTxt'),
                          fileName: widget.commissionImageName,
                          onPickTapped: () {
                            pickSingleImage(args.isSignutre!?3:7, args.isSignutre!);
                          },
                        ),

                      /// commissioner national card
                      if (paymentSecondScreenArgs.authorized!)
                        PickUpFileField(
                          chooseButtonTtx:getTrans(state: state, txtKey: 'chooseImageTxt'),
                          fieldLabel: getTrans(state: state, txtKey: 'comissionerNationlCardTxt'),
                          fileName: widget.commissionerNationalCardImageName,
                          onPickTapped: () {
                            pickSingleImage(args.isSignutre!?4:8, args.isSignutre!);
                          },
                        ),

                      /// next pervious buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomMediumButton(
                                buttonText: AppGeneralTrans.perviousButtomTxt,
                                onTap: () {
                                  saveScreenData();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomMediumButton(
                                buttonText: AppGeneralTrans.nextButtomTxt,
                                onTap: () {
                                  if (widget._formKey.currentState!.validate() &&
                                          checkCommisionValidation()&&checkSealValidate(args)&&checkSignatureValidate(args)
                                  ) {
                                    saveScreenData();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentSummaryScreen()));
                                  } else {
                                    showToastWidget( CustomToastWidget(
                                      toastStatus: ToastStatus.warning,
                                      toastContent:
                                          AppGeneralTrans.dataRequirementValidationTxt,
                                    ));
                                  }
                                },
                              ),
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          case PaymentThirdFormResponseStatus.error:
            {
              return RetryContainer(
                onRetry: () {
                  BlocProvider.of<PaymentThirdFormBloc>(context)
                      .add(GetPaymentThirdFormBlocEvent());
                },
                errorMessage: '${state.message}',
              );
            }
          default:
            {
              return Container();
            }
        }
      }),
    );
  }
  
  bool checkSignatureValidate(FirstScreenArgs args){
    if(args.isSignutre!){
      if(widget.issuanceRequestName.isNotEmpty &&
          widget
              .nationalCardImageName.isNotEmpty &&
          widget.singleContractImageName
              .isNotEmpty){
        return true;
      }else{
        return false;
      }
    }
    return true;
    
  }

  bool checkSealValidate(FirstScreenArgs args){
    if(!args.isSignutre!&&paymentSecondScreenArgs.freeMissions!){
      if(widget.taxCardPath.isNotEmpty&&widget.valueAddedCardName.isNotEmpty&&
      widget.issuanceRequestName.isNotEmpty&&widget.firstContractImageName.isNotEmpty&&widget.secondContractImageName.isNotEmpty
      &&widget.registerPersonCardName.isNotEmpty&&widget.discountNotificationPath!.isNotEmpty
      ){
        return true;
      }else{
        return false;
      }
    }else if(!args.isSignutre!&&!paymentSecondScreenArgs.freeMissions!){
      if(
      widget.fileName.isNotEmpty&&
      widget.taxCardPath.isNotEmpty&&widget.valueAddedCardName.isNotEmpty&&
          widget.issuanceOneName!.isNotEmpty&&widget.firstContractImageName.isNotEmpty&&widget.secondContractImageName.isNotEmpty
          &&widget.registerPersonCardName.isNotEmpty
      ){
        return true;
      }else{
        return false;
      }
    }
    return true;
  }
  
 bool checkCommisionValidation(){
   if(paymentSecondScreenArgs.authorized!){
     if(widget.commissionImageName.isNotEmpty&&widget.commissionerNationalCardImageName.isNotEmpty){
       return true;
     }else{
       return false;
     }
   }
   return true;
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        throw Exception('Storage Permission not granted');
      }
    }
  }

  Future<void> pickFile() async {
    await requestStoragePermission();
    await FilePicker.platform.pickFiles(
        dialogTitle: 'pdf',
        type: FileType.custom,
        withData: true,
        withReadStream: true,
        allowedExtensions: ['pdf']).then((value) {
      File file = File(value!.files.single.path!);
      final bytes = file.readAsBytesSync();
      final base64 = base64Encode(bytes);
      setState(() {
        widget.fileName = value.files.single.name;
        widget.filePath = value.files.first.path!;
        debugPrint('base 64 is ${widget.filePath}');
        // print(value.names);
      });
    }).onError((error, stackTrace) {
      showToastWidget(const CustomToastWidget(
        toastStatus: ToastStatus.error,
        toastContent:
            "can't load this file try another on ,consider file must be pdf ",
      ));
    });
  }

  Future<void> pickSingleImage(int index, bool isSignature) async {
    await ImagePicker.platform
        .getImage(
            source: ImageSource.gallery, maxHeight: 20.sp, maxWidth: 20.sp)
        .then((value) {
      File file = File(value!.path);
      final bytes = file.readAsBytesSync();
      final base64 = base64Encode(bytes);
      setState(() {
        if (!isSignature) {
          switch (index) {
            case 0:
              {
                widget.taxCardName = value.name;
                widget.taxCardPath = value.path;
              }
              break;
            case 1:
              {
                widget.valueAddedCardName = value.name;
                widget.valueAddedCardPath = value.path;
              }
              break;
            case 2:
              {
                widget.issuanceOnePath = value.path;
                widget.issuanceOneName = value.name;
                widget.issuanceRequestName = value.name;
                widget.issuanceRequestPath = value.path;
              }
              break;
            case 3:
              {
                widget.firstContractImageName = value.name;
                widget.firstContractImagePath = value.path;
              }
              break;
            case 4:
              {
                widget.secondContractImageName = value.name;
                widget.secondContractImagePath = value.path;
              }
              break;
            case 5:
              {
                widget.registerPersonCardName = value.name;
                widget.registerPersonCardPath = value.path;
              }
              break;
            case 6:
              {
                widget.discountNotificationImageName = value.name;
                widget.discountNotificationPath = value.path;
              }
              break;
            case 7:
              {
                widget.commissionImageName = value.name;
                widget.commissionImagePath = value.path;
              }
              break;
            case 8:
              {
                widget.commissionerNationalCardImageName = value.name;
                widget.commissionerNationalCardImagePath =value.path;
              }
          }
        } else {
          switch (index) {
            case 0:
              {
                widget.issuanceRequestName = value.name;
                widget.issuanceRequestPath = value.path;
              }
              break;
            case 1:
              {
                widget.nationalCardImageName = value.name;
                widget.nationalCardImagePath = value.path;
              }
              break;
            case 2:
              {
                widget.singleContractImageName = value.name;
                widget.singleContractImagePath = value.path;
              }
              break;
            case 3:
              {
                widget.commissionImageName = value.name;
                widget.commissionImagePath = value.path;
              }
              break;
            case 4:
              {
                widget.commissionerNationalCardImageName = value.name;
                widget.commissionerNationalCardImagePath = value.path;
              }
          }
        }
      });
    });
  }


  void saveScreenData() {
    paymentThirdScreenModel = PaymentThirdScreenModel(
      pdfName: widget.fileName,
      pdfPath: widget.filePath,
      taxCard: widget.taxCardName,
      taxCardPath: widget.taxCardPath,
      valueAddedCard: widget.valueAddedCardName,
      valueAddedCardPath: widget.valueAddedCardPath,
      issuanceRequest: widget.issuanceRequestName,
      issuanceRequestPath: widget.issuanceRequestPath,
      firstContractImage: widget.firstContractImageName,
      firstContractImagePath: widget.firstContractImagePath,
      secondContractImage: widget.secondContractImageName,
      secondContractImagePath: widget.secondContractImagePath,
      registerPersonCard: widget.registerPersonCardName,
      registerPersonCardPath: widget.registerPersonCardPath,
      nationalCardImageName: widget.nationalCardImageName,
      nationalCardPath: widget.nationalCardImagePath,
      singleContractImageName: widget.singleContractImageName,
      singleContractImagePath: widget.nationalCardImagePath,
      discountNotificationPath: widget.discountNotificationPath,
      discountNotificationImageName: widget.discountNotificationImageName,
      commissionImageName: widget.commissionImageName,
      commissionImagePath: widget.commissionImagePath,
      commissionerNationalCardImageName:
          widget.commissionerNationalCardImageName,
      commissionerNationalCardImagePath:
          widget.commissionerNationalCardImagePath,

    );
  }
}
