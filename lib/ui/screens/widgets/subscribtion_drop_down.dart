import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/bloc.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import '../../../models/utils/themes/app_general_trans.dart';
import '../../../models/utils/themes/colors.dart';
import '../main/payment/bloc/payment_second_form_bloc/states.dart';
import 'drop_down.dart';

class PaymentSubscriptionDropDown extends StatelessWidget {
  final PaymentSubscriptionModel? selectedSubscriptionObject;
  final Function(dynamic)? onChanged;
  final int?serviceId;
  final String?hint;
  const PaymentSubscriptionDropDown({Key? key,required this.hint,this.onChanged,this.selectedSubscriptionObject,this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  _buildDropDownsSubscriptionsItems();
  }

  _buildDropDownsSubscriptionsItems() {
    return BlocBuilder<PaymentSecondFormSubscriptionsBloc,
        GetSecondFormSubscriptionsDataStates>(builder: (context, state) {
      return DropDown2(
          value: selectedSubscriptionObject,
          items: _buildSubscriptionItems(state, context),
          hintIsVisible: true,
          hint: hint,
          validator: (val) {
            if (val == null) return AppGeneralTrans.subscriptionPeriodValidationTxt;
            return null;
          },
          onChanged: onChanged);
    });
  }

  _buildSubscriptionItems(GetSecondFormSubscriptionsDataStates state, BuildContext context) {
    switch (state.secondFormResponseStatus) {
      case SecondFormResponseStatus.loading:
        {
          return List<DropdownMenuItem>.generate(
              1,
                  (index) => DropdownMenuItem(
                  value: selectedSubscriptionObject,
                  child:const Center(
                    child: CircularProgressIndicator(),
                  )));
        }
      case SecondFormResponseStatus.error:
        {
          showToastWidget(CustomToastWidget(
            toastStatus: ToastStatus.error,
            toastContent:state.message??'',
          ),
            position: ToastPosition.bottom,
          );
          return List<DropdownMenuItem>.generate(
              1,
                  (index) => DropdownMenuItem(
                  value:selectedSubscriptionObject,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          child:Text('error,try again',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Palette.colorRed,fontSize: 8),),
                          onPressed: (){
                            BlocProvider.of<PaymentSecondFormSubscriptionsBloc>(context).add(GetSecondFormSubscriptionsDataEvent(serviceId:serviceId!));
                          },
                        ),
                      ),
                    ],
                  )));
        }
      case SecondFormResponseStatus.success:
        {
          return state.paymentSubscriptionModel!
              .map<DropdownMenuItem>((e) =>
              DropdownMenuItem(value: e, child: Text('${e.periodName}')))

              .toList();
        }
      default:
        {
          return List<DropdownMenuItem>.generate(
              1,
                  (index) => DropdownMenuItem(
                  value: selectedSubscriptionObject, child:const Text('select subscripition type')));
        }
    }
  }

}
