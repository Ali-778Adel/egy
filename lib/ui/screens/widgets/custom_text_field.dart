import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../models/utils/dimens.dart';

enum TextFieldTypes { email, userName, phone, date, randomText, number }

class CustomTextField extends StatelessWidget {
  final String? labelHint;
  final String? fieldHint;
  final TextEditingController textEditingController;
  final TextFieldTypes textFieldTypes;
  final int?maxLength;
  final String? Function(String? val)? validator;
  final Function(dynamic val)?onChanged;
  const CustomTextField(
      {Key? key,
      this.labelHint,
      this.fieldHint,
      this.validator,
        this.onChanged,
        this.maxLength,
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
              maxLength: maxLength,
              controller: textEditingController,
              keyboardType: checkKeyboardType,
              validator: validator,
              onChanged:onChanged ,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
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

class CustomDateTextField extends StatelessWidget {
  final String? labelHint;
  final String? fieldHint;
  final TextEditingController textEditingController;
  final TextFieldTypes textFieldTypes;
  final String? Function(String? val)? validator;

  const CustomDateTextField(
      {Key? key,
      this.labelHint,
      this.fieldHint,
      this.validator,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 50.sp,
          margin: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: checkKeyboardType,
            validator: validator,

            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              enabled: true,
              prefixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_rounded),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2050))
                      .then((value) {
                    textEditingController.text =
                        DateFormat('yyyy-MM-dd').format(value!);
                  });
                },
              ),
              hintText: fieldHint ?? "",
              isDense: true,
              isCollapsed: false,
              prefixIconConstraints: BoxConstraints(
                minHeight: 30.sp,
                maxHeight: 30.sp,
              ),
              // contentPadding:
              // EdgeInsets.symmetric(vertical: Dimens.space12),
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
    );
  }
}
