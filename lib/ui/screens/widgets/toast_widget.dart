import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum ToastStatus{warning,error,success}

class CustomToastWidget extends StatelessWidget{
  final ToastStatus? toastStatus;
  final String? toastContent;
  const CustomToastWidget({Key? key,this.toastStatus,this.toastContent}) : super(key: key);

  Color get checkToastStatus{
    switch(toastStatus){
      case ToastStatus.warning:{
        return Palette.colorYellow;
      }
      case ToastStatus.error:{
        return Palette.colorRed;
      }case ToastStatus.success:{
        return Palette.mainGreen;
    }
      default:{
        return Palette.mainBlue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.sp,
      decoration: BoxDecoration(
        color:checkToastStatus ,
        borderRadius: BorderRadius.all(Radius.circular(10.sp))
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Text('$toastContent',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white,fontWeight: FontWeight.w600),),
      ),
    );
  }

}