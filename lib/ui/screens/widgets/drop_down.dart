// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../models/utils/dimens.dart';
import '../../../models/utils/themes/colors.dart';

class DropDown<T> extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem<T>> items;
  final bool hintIsVisible;
  final String? hint;
  final ValueChanged<dynamic>? onChanged;
  final Widget? prefixIcon;

  const DropDown(
      {Key? key,
      this.value,
      required this.items,
      required this.hintIsVisible,
      this.hint,
      this.onChanged,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: hintIsVisible,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.sp),
            child: Text(
              hint ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Palette.mainBlue),
            ),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 4.sp),
          child: Center(
            child: DropdownButtonFormField(

              hint: Text('$hint',style: Theme.of(context).textTheme.bodyMedium,),
              isDense: true,
              style:Theme.of(context).textTheme.bodyMedium,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: false,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: Dimens.space12),
                  child: prefixIcon,
                ),
                prefixIconConstraints: BoxConstraints(
                  minHeight: Dimens.space24,
                  maxHeight: Dimens.space24,
                ),
                // contentPadding:
                // EdgeInsets.symmetric(vertical: Dimens.space12),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(Dimens.space4),
                  borderSide: BorderSide(color: Palette.disable),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.circular(Dimens.space4),
                  borderSide: BorderSide(color: Palette.mainBlue),
                ),
              ),
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDownButton2 extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final String selectedValue;
  final Function(dynamic  val) onChanged;
  final String? hint;
  const CustomDropDownButton2(
      {Key? key,
      this.hint,
      required this.onChanged,
      required this.items,
      required this.selectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.sp),
            child: Text(
              hint ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Palette.mainBlue),
            ),
          ),
        ),
        DropdownButton2(
          // buttonHeight: 40.sp,
          items: items,
          onChanged: onChanged,
          value: selectedValue,
          hint: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }
}

class DropDown2 extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem> items;
  final bool hintIsVisible;
  final String? hint;
  final ValueChanged<dynamic>? onChanged;
  final Widget? prefixIcon;
  final String? errorText;
  final String? Function(dynamic val)? validator;

  const DropDown2({
    Key? key,
    this.value,
    required this.items,
    required this.hintIsVisible,
    this.hint,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: hintIsVisible,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Text(
              hint ?? "",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Palette.mainBlue,),
            ),
          ),
        ),
        Center(
          child: DropdownButtonFormField2(
            alignment: Alignment.topRight,
            isDense: true,
            isExpanded: true,
            style: Theme.of(context).textTheme.bodyMedium,
            dropdownStyleData:DropdownStyleData(
              maxHeight:200.sp ,
              width: 180.sp,
              isFullScreen: false,
              isOverButton: false,
              offset:const Offset(20.0, -20.0),
              decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0.0, 2),
              blurRadius: 2.0,
              spreadRadius: 1.0,
              color: Colors.blueGrey),
        ]),
            ),

            hint: Text('$hint',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.black),),
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              errorStyle:Theme.of(context).textTheme.bodyMedium ,
              hintText: hint,
              isDense: false,
              isCollapsed: false,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: Dimens.space12),
                child: prefixIcon,
              ),

              enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(Dimens.space4),
                borderSide: BorderSide(color: Palette.disable),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(Dimens.space4),
                borderSide: BorderSide(color: Palette.mainBlue),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(Dimens.space4),
                borderSide: BorderSide(color: Palette.colorRed),
              ),
            ),
            value: value,
            items: items,
            onChanged: onChanged,
            validator: validator,
            onMenuStateChange: (val) {
              if (val == true) {
                print('state');
              }
            },
          ),
        ),
      ],
    );
  }
}
