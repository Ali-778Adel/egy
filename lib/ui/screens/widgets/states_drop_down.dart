import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../di/dependency_injection.dart';
import '../../../models/utils/themes/colors.dart';
import '../../../models/utils/themes/themes_bloc/bloc.dart';
import '../main/payment/bloc/payment_second_form_bloc/bloc.dart';
import '../main/payment/bloc/payment_second_form_bloc/events.dart';
import '../main/payment/bloc/payment_second_form_bloc/states.dart';
import 'drop_down.dart';

class PaymentStatesDropDown extends StatelessWidget {
  final PaymentStatesModel? selectedStateObject;
  final PaymentCitiesModel? selectedCitiesModel;
  final String fieldHint;
  final Function(dynamic)? onChanged;

   PaymentStatesDropDown(
      {Key? key,
      this.selectedStateObject,
      this.selectedCitiesModel,
      required this.fieldHint,
      this.onChanged})
      : super(key: key);

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
    return _buildDropDownsStatesItems();
  }

  _buildDropDownsStatesItems() {
    return BlocBuilder<PaymentSecondFormStatesBloc,
        GetSecondFormStatesDataState>(builder: (context, state) {
      return DropDown2(
          value: selectedStateObject,
          items: _buildStatesItems(state, context),
          hintIsVisible: true,
          hint: getTrans(state: state, txtKey: 'governorateTxt'),
          validator: (val) {
            if (val == null) {
              return AppGeneralTrans.statesValidationTxt;
            }
            return null;
          },
          onChanged: onChanged);
    });
  }

  _buildStatesItems(PaymentSecondFormStates state, BuildContext context) {
    if (state is GetSecondFormStatesDataState) {
      switch (state.secondFormResponseStatus) {
        case SecondFormResponseStatus.loading:
          {
            return List<DropdownMenuItem>.generate(
                1,
                (index) => const DropdownMenuItem(
                        child: Center(
                      child: CircularProgressIndicator(),
                    )));
          }
        case SecondFormResponseStatus.error:
          {
            showToastWidget(
              CustomToastWidget(
                toastStatus: ToastStatus.error,
                toastContent: state.message ?? '',
              ),
              position: ToastPosition.bottom,
            );
            return List<DropdownMenuItem>.generate(
                1,
                (index) => DropdownMenuItem(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Text(
                              'error,try again',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Palette.colorRed, fontSize: 8),
                            ),
                            onPressed: () {
                              BlocProvider.of<
                                          PaymentSecondFormSubscriptionsBloc>(
                                      context)
                                  .add(GetSecondFormStatesDataEvent());
                            },
                          ),
                        ],
                      ),
                    )));
          }
        case SecondFormResponseStatus.success:
          {
            return state.paymentStatesModel != null
                ? state.paymentStatesModel!
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.stateName!,style: Theme.of(context).textTheme.bodyMedium,)))
                    .toList()
                : List<DropdownMenuItem>.generate(
                    1, (index) =>  DropdownMenuItem(child: Text('حدث  خطا ما ',style: Theme.of(context).textTheme.bodyMedium,)));
          }
        default:
          return List<DropdownMenuItem>.generate(
              1,
              (index) => DropdownMenuItem(
                      child: Center(
                    heightFactor: 20.sp,
                    widthFactor: 20.sp,
                    child: CircularProgressIndicator(),
                  )));
      }
    } else {
      return List<DropdownMenuItem>.generate(
          1,
          (index) => const DropdownMenuItem(
                  child: Center(
                child: CircularProgressIndicator(),
              )));
    }
  }
}
