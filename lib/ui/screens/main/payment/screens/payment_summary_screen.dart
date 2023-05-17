import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/states.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_second_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_third_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/connection_error%20widget.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/entities/payment_entities/payment_register_user_data.dart';
import '../../../../../models/utils/themes/themes_bloc/bloc.dart';
import '../../../../../repository/common_function/url_launcher.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../../widgets/toast_widget.dart';
import '../../payment_auth/blocs/bloc.dart';
import '../../payment_auth/blocs/events.dart';
import '../../payment_auth/screens/payment_auth.dart';
import '../bloc/payment_registeration_bloc/bloc.dart';


class PaymentSummaryScreen extends StatefulWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreen();
}

class _PaymentSummaryScreen extends State<PaymentSummaryScreen> {
  bool rulesCheckBox = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentFourthScreensTransBloc>(context).add(GetFourthFormTransDataEvent());
  }

  String appLocal=sl<ThemeBloc>().appLocal;
  String getTrans({required  GetFourthFormTransDataState state,required String txtKey}){
    if(appLocal=='ar-SA'){
      return "${state.trans!.where((element) => element.key == txtKey).first.val}";
    }else if(appLocal=='en-US'){
      return "${state.trans!.where((element) => element.key == txtKey).first.valEn}";
    }else{
      return "لا يوجد نص";
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body:BlocListener<PaymentRegistrationBloc,PostUserDataState>(
        listener: (context,state){
            switch(state.paymentRegistrationResponseStatus){
              case PaymentRegistrationResponseStatus.error:{
                Navigator.pop(context);
                showToastWidget(CustomToastWidget(toastStatus: ToastStatus.error,toastContent: state.message,),position: ToastPosition.bottom);
              }break;
              case PaymentRegistrationResponseStatus.loading:{
                showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),));
              }break;
              case PaymentRegistrationResponseStatus.success:{
                BlocProvider.of<PaymentAuthBloc>(context).add(PaymentAuthEvents(
                    body: {
                      "CardId":paymentSecondScreenArgs.nationalId,
                      "userRef":state.paymentFormsResultModel!.password
                    }));
                debugPrint(state.paymentFormsResultModel!.password);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
               const PaymentAuthScreen()),(route)=>false);
              }break;
              default:{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(appBar: CustomAppBar(context: context).call(),body: Container(color: Colors.pinkAccent,height: 80.h,child: Text('${state.message}'),),)));
              }
            }
        },
        child:  BlocBuilder<PaymentFourthScreensTransBloc,GetFourthFormTransDataState>(
          builder: (context, state) {
              switch(state.paymentRegistrationResponseStatus){
                case PaymentRegistrationResponseStatus.loading:{
                  return const Center(child:  CircularProgressIndicator(),);
                }
                case PaymentRegistrationResponseStatus.error:{
                  return RetryContainer(onRetry: (){
                    BlocProvider.of<PaymentFourthScreensTransBloc>(context).add(GetFourthFormTransDataEvent());
                  }, errorMessage: state.message!);
                }
                case PaymentRegistrationResponseStatus.success:{
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///company or person field
                        Row(
                          children: [
                            _buildTileText(
                                context: context,
                                title:getTrans(state: state, txtKey:'companyTxt')

                                    ),
                            _buildTitleValue(
                                context: context,
                                value:
                                '${paymentSecondScreenArgs.companyName!.isEmpty ? paymentSecondScreenArgs.userName : paymentSecondScreenArgs.companyName}')
                          ],
                        ),

                        /// email field
                        Row(
                          children: [
                            _buildTileText(context: context, title:getTrans(state: state, txtKey: 'emailTxt')),
                            Expanded(
                              child: _buildTitleValue(
                                  context: context,
                                  value: '${paymentSecondScreenArgs.emailAddress}'),
                            )
                          ],
                        ),

                        /// phone number field
                        Row(
                          children: [
                            _buildTileText(context: context, title:getTrans(state: state, txtKey: 'mobileNumberTxt')),
                            _buildTitleValue(
                                context: context,
                                value: '${paymentSecondScreenArgs.phoneNumber}')
                          ],
                        ),

                        SizedBox(
                          height: 16.sp,
                        ),

                        /// rules field
                        Row(
                          children:   [
                            Expanded(
                                child: Text(
                                    getTrans(state: state, txtKey: 'noteTxt')
                                )),
                          ],
                        ),
                        Row(
                          children:   [
                            Expanded(
                                child: TextButton(
                                  onPressed: (){
                                    launchUrl1(getTrans(state: state, txtKey: 'firstUrlTxt'));
                                  },
                                  child: Text(
                                      getTrans(state: state, txtKey: 'firstUrlTxt'))
                                )),
                          ],
                        ),
                        Row(
                          children:   [
                            Expanded(
                                child: TextButton(
                                    onPressed: (){
                                      launchUrl1(getTrans(state: state, txtKey: 'secondUrlTxt'));
                                    },
                                    child: Text(
                                        getTrans(state: state, txtKey:'secondUrlTxt'))
                                )),
                          ],
                        ),

                        SizedBox(
                          height: 24.sp,
                        ),

                        /// check rules field
                        Row(
                          children: [
                            Expanded(
                                child: _buildTitleValue(
                                    context: context,
                                    value:getTrans(state: state, txtKey: 'rulesAgreementTxt')
                                )),
                            Checkbox(
                                value: rulesCheckBox,
                                onChanged: (val) {
                                  setState(() {
                                    rulesCheckBox = val!;
                                    // print('${paymentSecondScreenArgs.}');
                                  });
                                })
                          ],
                        ),
                        SizedBox(
                          height: 24.sp,
                        ),

                        ///next pervious buttons
                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: CustomMediumButton(
                                buttonText: AppGeneralTrans.perviousButtomTxt,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            BlocBuilder<PaymentRegistrationBloc,PaymentRegistrationStates>(
                                builder: (context, snapshot) {
                                  return Expanded(
                                    flex: 1,
                                    child: CustomMediumButton(
                                      buttonText:AppGeneralTrans.nextButtomTxt,
                                      onTap: ()async {
                                        if (rulesCheckBox) {
                                          BlocProvider.of<PaymentRegistrationBloc>(context)
                                              .add(PostUserDataEvent(requestBody:await fillBodyRequest() ));
                                        } else {
                                          showToastWidget(
                                               CustomToastWidget(
                                                toastStatus: ToastStatus.error,
                                                toastContent:AppGeneralTrans.rulesAgreementValidationTxt
                                              ),
                                              position: ToastPosition.bottom);
                                        }
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                default:{
                  return Container();
                }

              }


          }
        ),
      ),
    );
  }

  Widget _buildTileText(
      {required BuildContext context, required String title}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
    );
  }

  Widget _buildTitleValue(
      {required BuildContext context, required String value}) {
    return Text(
      value,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Palette.mainBlue, fontWeight: FontWeight.w400),
    );
  }


  Future<FormData>fillBodyRequest(){
    var paymentRegistrationModel=PaymentRegistrationUserDataModel(
      serviceId:paymentSecondScreenArgs.serviceId,
      servicesStatus: paymentSecondScreenArgs.serviceStatusId,
      stateId: paymentSecondScreenArgs.paymentStatesModel!.stateId,
      cityId: paymentSecondScreenArgs.paymentCitiesModel!.cityId,
      companyName: paymentSecondScreenArgs.companyName,
      taxNumber: paymentSecondScreenArgs.taxNumber,
      address: paymentSecondScreenArgs.address,
      email: paymentSecondScreenArgs.emailAddress,
      cardId: paymentSecondScreenArgs.nationalId,
      total: paymentSecondScreenArgs.total,
      commisionerCardId: paymentSecondScreenArgs.authorizedNationalId,
      commissionerName: paymentSecondScreenArgs.authorizedName,
      commissionerPhone:"${paymentSecondScreenArgs.authorizedSelectedServiceProvider}""${paymentSecondScreenArgs.authorizedPhoneNumber}",
      subscriptionId: paymentSecondScreenArgs.subscriptionId,
      isCommissioner: paymentSecondScreenArgs.authorized!?'True':'False',
      isThereDiscount: paymentSecondScreenArgs.discountNotification!?'True':'False',
      comorderCount: int.parse(paymentSecondScreenArgs.signatureNumber!.isEmpty?'0':paymentSecondScreenArgs.signatureNumber!),
      facebook: paymentSecondScreenArgs.facebookMessages,
      whats: paymentSecondScreenArgs.whatsAppMessages,
      issuanceTaxDate: paymentSecondScreenArgs.docStartDate,
      taxCardDate: paymentSecondScreenArgs.docEndDate,
      liberalProfessions: paymentSecondScreenArgs.freeMissions,
      mobileNumber:"${paymentSecondScreenArgs.selectedServiceProvider}""${paymentSecondScreenArgs.phoneNumber}",
      pdfPath:paymentThirdScreenModel!.pdfPath!,
      taxCardPath: paymentThirdScreenModel!.taxCardPath!,
      valueAddedCardPath: paymentThirdScreenModel!.valueAddedCardPath!,
      issuanceRequestPath: paymentThirdScreenModel!.issuanceRequestPath!,
      firstContractImagePath: paymentThirdScreenModel!.firstContractImagePath!,
      secondContractImagePath: paymentThirdScreenModel!.secondContractImagePath!,
      registerPersonCardPath: paymentThirdScreenModel!.registerPersonCardPath!,
      nationalCardPath: paymentThirdScreenModel!.nationalCardPath!,
      singleContractImagePath: paymentThirdScreenModel!.singleContractImagePath!,
      commissionImagePath: paymentThirdScreenModel!.commissionImagePath!,
      commissionerNationalCardImagePath: paymentThirdScreenModel!.commissionerNationalCardImagePath!,
      discountNotificationPath: paymentThirdScreenModel!.discountNotificationPath,
    );
    print('last toatl is ${paymentRegistrationModel.total}');
    return paymentRegistrationModel.formData(isCommissioner:paymentSecondScreenArgs.authorized!?'True':'False' );
  }

}
