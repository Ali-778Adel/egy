


import 'dart:async';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';

class BottomSheetCertificationRevokeConfirmation extends StatefulWidget {
  final String message, title;
  final int initTime;
  final VoidCallback? onPositiveTap;
  final String? positiveText;

  const BottomSheetCertificationRevokeConfirmation({Key? key,
    required this.title,
    required this.message,
    required this.onPositiveTap,
    required this.initTime,
    this.positiveText
  }) : super(key: key);


  static Future<bool> show(BuildContext context,
      {int initTime = 5,  String? positiveText, required String title, required String message, required VoidCallback? onPositiveTap}) async {
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return BottomSheetCertificationRevokeConfirmation(
          title: title, message: message, onPositiveTap: onPositiveTap,initTime: initTime,positiveText: positiveText,);
      },
    );


    return true;
  }

  @override
  _StateBottomSheetCertificationRevokeConfirmation createState() => _StateBottomSheetCertificationRevokeConfirmation();
}

  class _StateBottomSheetCertificationRevokeConfirmation extends State<BottomSheetCertificationRevokeConfirmation>{


    Timer? _timer;
    int _timeInSeconds = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }
  void _startTimer() {
    _timeInSeconds = widget.initTime;
    if(_timeInSeconds <= 0) return;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if(mounted != true) return;
        setState(() {
          if (_timeInSeconds == 0) {
            timer.cancel();
          } else {
            _timeInSeconds--;
          }
        });

      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Text(
           widget.title,

            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: UiConstants.colorTitle),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Text(
            widget.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: UiConstants.colorRed),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0 , horizontal: 20),
          child: Row(children: [


            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  appLocalization.back.toUpperCase(),
                  style:Theme.of(context).textTheme.bodyLarge
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(const Size(
                        double.infinity, 45)),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        UiConstants.colorPrimary),

                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side:  BorderSide(
                                color: UiConstants.colorPrimary)))),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: TextButton(

                    onPressed: _timeInSeconds != 0
                        ? null
                        : ()async{
                      Navigator.of(context).pop();
                      widget.onPositiveTap?.call();
                    },
                    child: Text(
                      _timeInSeconds != 0 ? '$_timeInSeconds' : (widget.positiveText == null ? appLocalization.confirm.toUpperCase() : widget.positiveText?.toUpperCase()) ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white)),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>( Size(_timeInSeconds != 0 ? 45 : double.infinity, 45)),
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
              ),
            ),
          ],),
        ),

      ],
    );
  }


}
