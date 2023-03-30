


import 'dart:async';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';

import '../../../models/utils/themes/colors.dart';

class BottomSheetUpdateMessageConfirmation extends StatefulWidget {
  final String message;
  final bool canProceed;


  const BottomSheetUpdateMessageConfirmation({Key? key,

    required this.message,
    this.canProceed = true
  }) : super(key: key);


  static Future<bool> show(BuildContext context,
      {  required String message, bool canProceed = true}) async {
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return BottomSheetUpdateMessageConfirmation(
           message: message, canProceed: canProceed,);
      },
    );


    return true;
  }

  @override
  _StateBottomSheetMessageConfirmation createState() => _StateBottomSheetMessageConfirmation();
}

  class _StateBottomSheetMessageConfirmation extends State<BottomSheetUpdateMessageConfirmation>{





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text(
             appLocalization.appUpdate,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: UiConstants.colorTitle),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text(
              widget.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: UiConstants.colorTitle),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0 , horizontal: 20),
            child: Row(children: [


              if(widget.canProceed == true)
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    appLocalization.next.toUpperCase(),
                    style:  Theme.of(context).textTheme.bodyLarge
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(const Size(
                          double.infinity, 45)),

                      backgroundColor: MaterialStateProperty.all<Color>(
                          UiConstants.colorRed),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(UiConstants
                          .colorTitle),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: const BorderSide(
                                  color: UiConstants.colorRed)))),
                ),
              ),
              if(widget.canProceed == true)
              const SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    OpenStore.instance.open(
                      appStoreId: '1609251000', // AppStore id of your app
                      androidAppBundleId: 'com.Alfa.egytrustapp', // Android app bundle package name
                    );
                  },
                  child: Text(
                    appLocalization.update.toUpperCase(),
                    style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white)
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(const Size(
                          double.infinity, 45)),

                      backgroundColor: MaterialStateProperty.all<Color>(
                          UiConstants.colorPrimary),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side:  BorderSide(
                                  color: UiConstants.colorPrimary)))),
                ),
              ),

            ],),
          ),

        ],
      ),
    );
  }


}
