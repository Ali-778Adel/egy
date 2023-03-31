import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/qr_scanner.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QrSignatureCustomField extends StatelessWidget {
  final String? fieldLabel;
  final Function() onPickTapped;
  final String? licienceName;
  final List<String>? filesName;
  final String chooseButtonTtx;
  const QrSignatureCustomField(
      {Key? key,
        required this.fieldLabel,
        required this.onPickTapped,
        this.filesName,
        required this.chooseButtonTtx,
        this.licienceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Text(
            fieldLabel ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Palette.mainBlue),
          ),
        ),

         Container(
           decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10.sp)),
               border: Border.all(color: Palette.black)),
           child: Row(
             children: [
               if(qrArgs.signature==null)
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 8.sp),
                 child: InkWell(
                   onTap: onPickTapped,
                   child: Wrap(
                     children: [
                        Icon(Icons.qr_code_2_outlined,color: Palette.mainBlue,),
                       SizedBox(width: 2.w,),
                       Text("امسح ال QR كود تاخاص بك للحصول على البصمة الخاصة بك ",style: Theme.of(context).textTheme.bodyMedium,)
                     ],
                   ),
                 ),
               ),
                 Expanded(
                   child: Container(
                     margin:
                     EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                     padding:
                     EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                     child: Stack(
                       children: [
                         Text(
                           '$licienceName',
                           style: Theme.of(context).textTheme.bodyMedium,
                         ),

                       ],
                     ),
                   ),
                 ),

             ],
           ),
         ),
      ],
    );
  }
}