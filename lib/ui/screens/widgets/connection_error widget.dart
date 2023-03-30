import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/utils/themes/colors.dart';

class RetryContainer extends StatelessWidget {
  final VoidCallback onRetry;
  final String errorMessage;

  const RetryContainer({Key? key, required this.onRetry, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: errorMessage,
            style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.red,),
          ),

        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child:  Text('اعد المحاولة ',style: TextStyle(color:Colors.white,fontStyle: FontStyle.normal),),
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>( Size(40.sp,30.sp)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xffA1C858)),
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side:const  BorderSide(
                          color:Color(0xffA1C858))))),
        ),
      ],
    );
  }
}