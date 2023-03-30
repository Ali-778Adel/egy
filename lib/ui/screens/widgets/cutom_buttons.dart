import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomMediumButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonText;
  final bool isValidate;
  final double? buttonWidth;
  const CustomMediumButton(
      {Key? key, this.buttonText, this.buttonWidth, this.onTap, this.isValidate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.sp),
              topRight: Radius.circular(5.sp),
              bottomRight: Radius.circular(5.sp),
              bottomLeft: Radius.zero),
          color: isValidate ? Palette.mainBlue : Palette.mainGreen,
        ),
        width: buttonWidth,
        height: 36.sp,
        child: Center(
          child: Text(
            buttonText ?? 'التالي',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Palette.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
