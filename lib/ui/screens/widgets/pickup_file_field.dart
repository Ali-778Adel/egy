import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PickUpFileField extends StatelessWidget {
  final String? fieldLabel;
  final Function() onPickTapped;
  final String? fileName;
  final List<String>? filesName;
  final String chooseButtonTtx;
  final bool isMultiple;
  const PickUpFileField(
      {Key? key,
      required this.fieldLabel,
      required this.onPickTapped,
      this.isMultiple = false,
      this.filesName,
       required this.chooseButtonTtx,
      this.fileName})
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: InkWell(
                  onTap: onPickTapped,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Palette.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                    ),
                    child:  RowDropdown(
                      label: chooseButtonTtx,
                    ),
                  ),
                ),
              ),
              if (!isMultiple)
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                    child: Stack(
                      children: [
                        Text(
                          '$fileName',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                      ],
                    ),
                  ),
                ),
              if (isMultiple)
                 Expanded(
                   child: SizedBox(
                     height: 40.sp,
                     child: ListView.builder(
                         itemCount: filesName!.length,
                         itemBuilder: (context, index) {
                           return Container(
                             margin: EdgeInsets.symmetric(
                                 vertical: 1.sp, horizontal: 8.sp),
                             padding: EdgeInsets.symmetric(
                                 horizontal: 16.sp,),
                             child: Stack(
                               children: [
                                 Text(
                                   filesName![index],
                                   style: Theme.of(context).textTheme.bodyMedium,
                                 ),
                                 Positioned(
                                     width: 15.sp,
                                     height: 15.sp,
                                     top: -5.0,
                                     left: -5.0,
                                     child: FittedBox(
                                       fit: BoxFit.contain,
                                       child: IconButton(
                                           color: Palette.colorRed,
                                           onPressed: () {},
                                           icon: Icon(
                                             Icons.close,
                                             size: 15.sp,
                                           )),
                                     )),
                               ],
                             ),
                           );
                         }),
                   ),
                 )
            ],
          ),
        ),
      ],
    );
  }
}
