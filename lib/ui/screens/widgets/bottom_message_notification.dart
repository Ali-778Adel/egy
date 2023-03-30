
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';

import '../../../models/utils/themes/colors.dart';

class BottomSheetMessageNotification extends StatelessWidget{
  final String message;
  const BottomSheetMessageNotification({Key? key, required this.message}) : super(key: key);



  static Future<bool> show(BuildContext context , {required String label})async{
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10) , topLeft: Radius.circular(10)),
      ),
      context: context,
        isScrollControlled: true,
      builder: (BuildContext context) {
        return  BottomSheetMessageNotification(message: label,);
      },
    );


    return true;
    }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25,),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Text(
             message,

              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: UiConstants.colorTitle),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(appLocalization.ok.toUpperCase(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 45)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      UiConstants.colorPrimary),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                              color: UiConstants.colorPrimary)))),
            ),
          ),
        ),
      ],
    );
  }


}
