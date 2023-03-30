import 'package:fl_egypt_trust/data/services/fawry_payment_service.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_registeration_bloc/states.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/follow_order_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/utils/themes/app_general_trans.dart';
import '../../../bottom_navigations/bottom_navigation_handler.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../../widgets/toast_widget.dart';
import '../../redesign_home/pages/new_home_screen.dart';
import '../bloc/fawry_bloc/bloc.dart';
import '../bloc/fawry_bloc/bloc_events.dart';
import '../bloc/fawry_bloc/bloc_states.dart';
import '../bloc/payment_registeration_bloc/bloc.dart';


class PaymentSummaryScreenTest extends StatefulWidget {
  const PaymentSummaryScreenTest({Key? key}) : super(key: key);

  @override
  State<PaymentSummaryScreenTest> createState() => _PaymentSummaryScreen();
}

class _PaymentSummaryScreen extends State<PaymentSummaryScreenTest> {
  bool rulesCheckBox = false;
  @override
  void initState() {
    super.initState();
    sl<FarwryPaymentService>().initSDKCallback(context);
  }
  @override
  Widget build(BuildContext context) {
    final args= ModalRoute.of(context)!.settings.arguments as FollowOrderArgs;
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body:BlocListener<FawryBloc,FawryStates>(
        listener: (context,state){
          print(' i am in side listener _+++++++++++_+_+_+_+_+_+_');
          if(state is FawryCallBackState){
            switch(state.paymentProcessStatus){
              case PaymentProcessStatus.error:{
                showToastWidget(CustomToastWidget(toastStatus: ToastStatus.error,toastContent: state.message,));
              }break;
              case PaymentProcessStatus.loading:{
                showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),));
              }break;
              case PaymentProcessStatus.success:{
                print('successssssss*******************************************************');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                    Scaffold(
                      appBar: CustomAppBar(context: context).call(),
                      body: Column(
                        children: [
                          SizedBox(height: 10.h,),
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: RichText(
                                  textScaleFactor: 1.2,
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: '${AppGeneralTrans.waitFawryConfirmationTxt} ',style: Theme.of(context).textTheme.bodyMedium)
                                        , TextSpan(text:'\n ',style: Theme.of(context).textTheme.bodyMedium),
                                        TextSpan(text: '${AppGeneralTrans.refNumberValidationTxt} ',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue))
                                        , TextSpan(text:'\n ',style: Theme.of(context).textTheme.bodyMedium),
                                        TextSpan(text:AppGeneralTrans.refNumTxt,style: Theme.of(context).textTheme.bodyMedium),
                                        TextSpan(text: '${state.response!['referenceNumber']}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600,color: Palette.mainBlue))
                                      ]
                                  ),),
                              )
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>const FollowOrderScreen()), (route) => false);
                            },
                            child:  Text('الرجوع لمراقبة الطلب ',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>( Size(40.sp,30.sp)),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Palette.mainGreen),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        side:  BorderSide(
                                            color: Palette.mainGreen)))),
                          ),

                        ],
                      ),),),(route)=>false);              }break;
              case PaymentProcessStatus.completed:{
                showDialog(context: context, builder: (context)=>Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    CircularProgressIndicator(),
                    Text('please wait ...')
                  ],
                ));
                showToastWidget(const CustomToastWidget(toastStatus: ToastStatus.success,toastContent: 'completed...'),position: ToastPosition.bottom);
                // Navigator.pushAndRemoveUntil(context,
                //     MaterialPageRoute(
                //         builder: (context)=>
                //             Scaffold(
                //               appBar: CustomAppBar(
                //                   context: context,pageTitle: 'Fawry',onPop: (){
                //                     Navigator.pushAndRemoveUntil
                //                       (context,MaterialPageRoute(builder: (context)=>const FollowOrderScreen()),(route)=>false);
                //               }).call(),
                //               body: Center(child: Container(
                //                 color: Colors.white,height: 80.h,child: Text('${state.message}',style: Theme.of(context).textTheme.bodyMedium,),),)
                //             ))
                // ,(route)=>false);

              }break;
              default:{

              }
            }
          }
          else if(state is FawryInitState){
            showToastWidget(const CustomToastWidget(toastStatus: ToastStatus.warning,toastContent: 'please wait....',));
          }else if (state is FawryInitiateStates){
            print('i am here ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
            showToastWidget(const CustomToastWidget(toastStatus: ToastStatus.warning,toastContent: 'please wait....',));

          }
        },
        child:  SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///company or person field

              SizedBox(
                height: 16.sp,
              ),

              /// rules field
              Row(
                children: const [
                  Expanded(
                      child: Text(
                          "ب استكمال خطوات تقديم خدمة التوقيع او الختم الالكتروني  دون أدنى مسئولية على شركة إيجيبت تراست يقر مقدم طلب  الحصول على التوقيع والختم الإلكتروني  بأن البيانات المقدمة من طرفه هي بيانات صحيحة ومطابقة لآخر تحديث للمستندات الرسمية الأصلية لعميل مقدم هذا الطلب دون أدني مسئولية قانونية علي شركة إيجيبت تراست، وفي حالة وجود أي إختلاف بين البيانات المقدمة وآخر تحديث للمستندات الرسمية يتعهد بتحديث جميع البيانات من خلال البوابة الإلكترونية الخاصه بنا كما يتعهد ويلتزم بتسليم شركة إيجيبت تراست أو من ينوب عنها جميع المستندات المطلوبة موقعة ومختومة بالصيغة المنوه عنها في نماذج المستندات المطلوبة الخاصة بشركة إيجيبت تراست والموجودة على الروابط التالي")),
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
                          value:
                          'اقر بانني قرأت جميع البيانات والشروط المرفقة وبان جميع هذة البيانات تفع على مسؤليتى الخاصي ')),
                  Checkbox(
                      value: rulesCheckBox,
                      onChanged: (val) {
                        setState(() {
                          rulesCheckBox = val!;
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
                  Expanded(
                    child: BlocBuilder<PaymentRegistrationBloc,PaymentRegistrationStates>(
                        builder: (context, snapshot) {
                          return CustomMediumButton(
                            buttonText: AppGeneralTrans.nextButtomTxt,
                            onTap: ()async {
                              if (rulesCheckBox) {
                                BlocProvider.of<FawryBloc>(context).add(
                                    InitiateFawryPaymentEvent(
                                        price: args.total!,
                                        userRefNumber: args.userRefNumber!,
                                      customerMobile: args.customerMobile!,
                                      customerMail: args.customerMail!,
                                      merchantRefNumber: args.merchantRefNumber!

                                    ));
                              } else {
                                showToastWidget(
                                    const CustomToastWidget(
                                      toastStatus: ToastStatus.error,
                                      toastContent:
                                      'يجب الموافقة على اقرار صحة البيانات اولا  قبل الانتقال الى عملية الدفع. ',
                                    ),
                                    position: ToastPosition.bottom);
                              }
                            },
                          );
                        }
                    ),
                  ),


                ],
              ),
            ],
          ),
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
          .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
    );
  }

  Widget _buildTitleValue(
      {required BuildContext context, required String value}) {
    return Text(
      value,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Palette.mainBlue, fontWeight: FontWeight.w500),
    );
  }
}
