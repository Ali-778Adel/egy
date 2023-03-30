import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/follow_order_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../di/dependency_injection.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../follow_orders_login/screens/follow_orders_login_screen.dart';
import '../bloc/follow_order_bloc/bloc.dart';
import '../bloc/follow_order_bloc/events.dart';

class PaymentControllerScreen extends StatelessWidget {
  const PaymentControllerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context:context).call(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.sp,horizontal: 16.sp),
        child: Center(
          child:Column(
            children: [
              CustomMediumButton(
                buttonText: AppGeneralTrans.followOrderTxt,
                buttonWidth: 90.w,
                onTap: ()async{
                  if(await checkPaymentToken()){
                    BlocProvider.of<FollowOrderBloc>(context).add(FollowOrderEvent());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FollowOrderScreen()));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  FollowOrdersLoginScreen()));
                  }

                },
              ),
              SizedBox(
                height: 32.sp,
              ),
              CustomMediumButton(
                buttonText: AppGeneralTrans.buySealTxt,
                buttonWidth: 90.w,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentFirstFormScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> checkPaymentToken()async{
    final token=await sl<AppPreference>().getUserPaymentToken();
    if(token!=null&&token.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
}
