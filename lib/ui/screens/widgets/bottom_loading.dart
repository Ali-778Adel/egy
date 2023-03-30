



import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';

class BottomSheetLoading extends StatelessWidget{
  final String message;
  const BottomSheetLoading({Key? key, required this.message}) : super(key: key);



  static Future<bool> show(BuildContext context , {required String label})async{
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10) , topLeft: Radius.circular(10)),
      ),
      context: context,
        isDismissible: false,
        isScrollControlled: true,
      builder: (BuildContext context) {
        return  BottomSheetLoading(message: label,);
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: UiConstants.colorTitle),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Center(
            child: TextButton(
              onPressed: null,
              child: const CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.white)),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(45, 45)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      UiConstants.colorPrimary),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side:  BorderSide(
                              color: UiConstants.colorPrimary)))),
            ),
          ),
        ),
      ],
    );
  }


}
