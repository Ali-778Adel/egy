import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/utils/dimens.dart';
import '../../../models/utils/themes/colors.dart';
import 'custom_text_field.dart';

class CustomPasswordTextField extends StatelessWidget {
  final String? labelHint;
  final String? fieldHint;
  final TextEditingController textEditingController;
  final TextFieldTypes textFieldTypes;
  final int?maxLength;
  bool obsecureText;
  final String? Function(String? val)? validator;
  final Function(dynamic val)?onChanged;
  final Function ()?onIconTapped;
   CustomPasswordTextField(
      {Key? key,
        this.labelHint,
        this.fieldHint,
        this.validator,
        this.onChanged,
        this.maxLength,
        this.obsecureText=false,
        this.onIconTapped,
        required this.textEditingController,
        required this.textFieldTypes})
      : super(key: key);

  TextInputType get checkKeyboardType {
    switch (textFieldTypes) {
      case TextFieldTypes.email:
        {
          return TextInputType.emailAddress;
        }
      case TextFieldTypes.phone:
        {
          return TextInputType.phone;
        }
      case TextFieldTypes.userName:
        {
          return TextInputType.name;
        }
      case TextFieldTypes.date:
        {
          return TextInputType.datetime;
        }
      case TextFieldTypes.randomText:
        {
          return TextInputType.text;
        }
      case TextFieldTypes.number:
        {
          return TextInputType.number;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Text(
              labelHint ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Palette.mainBlue),
            ),
          ),
          Container(
            // height: 50.sp,
            margin: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
            child: TextFormField(
              obscureText: obsecureText,
              maxLength: maxLength,
              controller: textEditingController,
              keyboardType: checkKeyboardType,
              validator: validator,
              onChanged:onChanged ,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                suffixIcon:IconButton(onPressed:onIconTapped, icon: Icon(obsecureText?Icons.visibility_off:Icons.visibility,color: Palette.mainBlue,),),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                hintText: fieldHint ?? "",
                isDense: true,
                isCollapsed: false,
                errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                prefixIconConstraints: BoxConstraints(
                  minHeight: Dimens.space24,
                  maxHeight: Dimens.space24,
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(Dimens.space4),
                  borderSide:  BorderSide(color: Palette.disable),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(Dimens.space4),
                  borderSide:  BorderSide(color: Palette.mainBlue),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(Dimens.space4),
                  borderSide:  BorderSide(color: Palette.colorRed),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
