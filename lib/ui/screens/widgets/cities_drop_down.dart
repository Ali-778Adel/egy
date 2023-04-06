import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/utils/themes/colors.dart';
import '../../../models/utils/themes/themes_bloc/bloc.dart';
import '../main/payment/bloc/payment_second_form_bloc/bloc.dart';
import '../main/payment/bloc/payment_second_form_bloc/states.dart';
import 'drop_down.dart';

class PaymentCitiesDropDown extends StatelessWidget {
  final PaymentCitiesModel? selectedCityObject;
  final Function(dynamic)? onChanged;
  final String fieldHint;
  final int?stateId;
   PaymentCitiesDropDown(
      {Key? key, this.selectedCityObject, this.onChanged,required this.fieldHint,this.stateId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDropDownsCitiesItems();
  }

  _buildDropDownsCitiesItems() {
    return BlocBuilder<PaymentSecondFormCitiesBloc,
        GetSecondFormCitiesDataState>(builder: (context, state) {
      return DropDown2(
          value: selectedCityObject,
          items: _buildCitiesItems(state, context),
          hintIsVisible: true,
          hint:fieldHint,
          validator: (val) {
            if (val == null) return AppGeneralTrans.cityValidationTxt;
            return null;
          },
          onChanged: onChanged);
    });
  }

  _buildCitiesItems(GetSecondFormCitiesDataState state, BuildContext context) {
    switch (state.secondFormResponseStatus) {
      case SecondFormResponseStatus.loading:
        {
          return List<DropdownMenuItem>.generate(
              1,
              (index) => DropdownMenuItem(
                  value: selectedCityObject,
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
                  value: selectedCityObject,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                         child:Text('error,try again',
                    style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Palette.colorRed,fontSize: 8.sp)),
                          onPressed: (){
                           BlocProvider.of<PaymentSecondFormCitiesBloc>(context).add(GetSecondFormCitiesDataEvent(stateId:stateId!));
                          },
                        ),
                      ),
                    ],
                  )));
        }
      case SecondFormResponseStatus.success:
        {
          return state.paymentCitiesModel!
              .map<DropdownMenuItem>((e) =>
                  DropdownMenuItem(value: e, child: Text('${e.cityName}')))
              .toList();
        }
      default:
        {
          return List<DropdownMenuItem>.generate(
              1,
              (index) => DropdownMenuItem(
                  value: selectedCityObject, child: Text(AppGeneralTrans.chooseStateFirst)));
        }
    }
  }
}
class PaymentCitiesDropDown1 extends StatelessWidget {
  final PaymentCitiesModel? selectedCityObject;
  final Function(dynamic)? onChanged;
  final String fieldHint;
  final int?stateId;
   PaymentCitiesDropDown1(
      {Key? key, this.selectedCityObject, this.onChanged,required this.fieldHint,this.stateId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDropDownsCitiesItems();
  }

  _buildDropDownsCitiesItems() {
    return BlocBuilder<PaymentSecondFormCitiesBloc,
        GetSecondFormCitiesDataState>(builder: (context, state) {
      return DropDown2(
          value: selectedCityObject,
          items: _buildCitiesItems(state, context),
          hintIsVisible: true,
          hint:fieldHint,
          validator: (val) {
            if (val == null) return AppGeneralTrans.cityValidationTxt;
            return null;
          },
          onChanged: onChanged);
    });
  }

  _buildCitiesItems(GetSecondFormCitiesDataState state, BuildContext context) {
    return List<DropdownMenuItem>.generate(
        1,
            (index) => DropdownMenuItem(
            value: selectedCityObject,
            child: TextButton(
              child:Text('error,try again',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Palette.colorRed,fontSize: 8.sp)),
              onPressed: (){
                BlocProvider.of<PaymentSecondFormCitiesBloc>(context).add(GetSecondFormCitiesDataEvent(stateId:stateId!));
              },
            )));
  }
}
