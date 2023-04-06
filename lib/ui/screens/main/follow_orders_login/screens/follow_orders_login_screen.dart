import 'package:fl_egypt_trust/ui/screens/main/follow_orders_login/bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/follow_order_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/utils/app_preference.dart';
import '../../../../../models/utils/language/localizations_delegate.dart';
import '../../../../../models/utils/themes/app_general_trans.dart';
import '../../../../../models/utils/themes/colors.dart';
import '../../../widgets/custom_password_text_field.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/toast_widget.dart';
import '../bloc/events.dart';
import '../bloc/states.dart';

class FollowOrdersLoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _FollowOrdersLoginScreen();
  }

}

class _FollowOrdersLoginScreen extends State<FollowOrdersLoginScreen> {
  final nationalIdController = TextEditingController();
  final refrenceNumberController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

   bool obSecureText=true;


   String? checkVal({String? val, bool? condition, String? errorMessage}) {
     if (val == null || condition!) {
       return errorMessage;
     }
     return null;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: BlocListener<FollowOrderLoginBloc,FollowOrderLoginStates>(
        listener: (context,state){
            if(state.paymentAuthResponseStatus==FollowOrdersLoginResponseStatus.success){
              sl<AppPreference>().setUserPaymentToken(
                  userPaymentToken: state.paymentAuthModel!.token!);
              debugPrint(
                  'user token cached successfully ${state.paymentAuthModel!.token}');
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const FollowOrderScreen()), (route) => false);
            }
            if(state.paymentAuthResponseStatus==FollowOrdersLoginResponseStatus.error){
              showToastWidget( CustomToastWidget(
                toastStatus: ToastStatus.error,
                toastContent:state.message??'حدث خطأ ما حاول مرة اخري ',
              ),position: ToastPosition.bottom);
            }
        },
        child: BlocBuilder<FollowOrderLoginBloc,FollowOrderLoginStates>(
          builder: (context,state){
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        maxLength: 14,
                        textEditingController: nationalIdController,
                        textFieldTypes: TextFieldTypes.email,
                        labelHint:AppGeneralTrans.nationalIdTitleTxt,
                        fieldHint:
                        ' ${AppGeneralTrans.enterTxt}'
                            '${AppGeneralTrans.natioanalIdTxt1}',
                        validator: (val) {
                          return checkVal(
                              val: val,
                              condition: val!.length!=14,
                              errorMessage: AppGeneralTrans.natioanalIdTxt1);
                        }),
                    SizedBox(height: 4.sp,),
                    CustomPasswordTextField(
                        textEditingController: refrenceNumberController,
                        textFieldTypes: TextFieldTypes.number,
                        obsecureText: obSecureText,
                        onIconTapped: (){
                          setState(() {
                            obSecureText=!obSecureText;
                          });
                        },
                        labelHint:AppGeneralTrans.secretKeyTxtTxt,
                        fieldHint:
                            '${AppGeneralTrans.enterTxt } ${AppGeneralTrans.secretKeyTxtTxt}',
                        validator: (val) {
                          return checkVal(
                              val: val,
                              condition: val!.isEmpty,
                              errorMessage: AppGeneralTrans.secretKeyTxtTxt);
                        }),


                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child:TextButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              BlocProvider.of<FollowOrderLoginBloc>(context).add(FollowOrderLoginEvents(
                                  body: {
                                    "CardId":nationalIdController.text,
                                    "userRef":refrenceNumberController.text
                                  }
                              ));
                            }else{
                              showToastWidget( CustomToastWidget(
                                toastStatus: ToastStatus.error,
                                toastContent:AppGeneralTrans.dataRequirementValidationTxt,
                              ),position: ToastPosition.bottom);
                            }

                          },
                          style: ButtonStyle(
                              minimumSize:
                              MaterialStateProperty.all<Size>(Size(
                                  state.paymentAuthResponseStatus == FollowOrdersLoginResponseStatus.loading
                                      ? 45
                                      : double.infinity,
                                  45)),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Palette.mainGreen),
                              foregroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(35.0),
                                      side:
                                      BorderSide(color: Palette.mainGreen)))),
                          child: state.paymentAuthResponseStatus==FollowOrdersLoginResponseStatus.loading?
                          const SizedBox(
                              width: 35,
                              height: 35,
                              child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      Colors.white))):
                          Text(
                            appLocalization.login.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ) ,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
