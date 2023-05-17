import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/utils/themes/app_general_trans.dart';
import '../main/payment/bloc/payment_second_form_bloc/states.dart';
import 'drop_down.dart';

class ServiceSupplierDropdown extends StatelessWidget {
  final String selectedProvider;
  final Function(dynamic val)onChanged;

   ServiceSupplierDropdown({Key? key,required this.selectedProvider,required this.onChanged}) : super(key: key);
   List<String>mobileServiceProviders=['010','012','011','015'];
  @override
  Widget build(BuildContext context) {
    return _buildDropDownsCitiesItems();
  }

  _buildDropDownsCitiesItems() {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 7.sp),
      child: DropDown2(
          value: selectedProvider,
          items: _buildCitiesItems(),
          hintIsVisible: true,
          hint:"مزود الخدمة"
              "",
          validator: (val) {
            if (val == null) return AppGeneralTrans.cityValidationTxt;
            return null;
          },
          onChanged: onChanged),
    );
  }
  _buildCitiesItems() {
    return mobileServiceProviders
        .map<DropdownMenuItem>((e) =>
        DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }
}