import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/utils/certification_key_asset.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_certification_revoke_confirmation.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_loading.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../../models/entities/public_entities/certification_model.dart';
import '../../../../models/utils/themes/colors.dart';
import '../../../../models/utils/themes/colors.dart';
import '../../../../models/utils/themes/colors.dart';


class RowCertification extends StatelessWidget {
  final CertificationData certification;
  final VoidCallback? onRevokeTap , onRequestPinTap;

  const RowCertification({Key? key, required this.certification , this.onRequestPinTap , this.onRevokeTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: UiConstants.colorCertificationCard,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: certification.restOfData?.length,
                    itemBuilder: (_, index) {
                      var dd = certification.restOfData?.elementAt(index);
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: UiConstants.colorCertificationCard, // border color
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(CertificationKeyAssetChecker.getAssetPath(dd?.key)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dd?.key ?? '',
                                      style: const TextStyle(fontWeight:FontWeight.bold , color: UiConstants.colorTitle),
                                    ),
                                    Text(
                                      dd?.value ?? '',
                                      style: const TextStyle( color: UiConstants.colorHint),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        BottomSheetMessageConfirmation.show(context, title: appLocalization.requestPinTitle, message: appLocalization.requestPinMessage, onPositiveTap: onRequestPinTap);
                      },
                      child: Text(
                        appLocalization.requestPin.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(const Size(
                              double.infinity, 45)),


                          backgroundColor: MaterialStateProperty.all<Color>(
                              Palette.mainGreen),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side:  BorderSide(
                                      color: Palette.mainGreen)))),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        BottomSheetCertificationRevokeConfirmation.show(context, title: appLocalization.revokeTitle, message: appLocalization.revokeMessage, onPositiveTap: onRevokeTap, positiveText: appLocalization.revokeCertification);
                      },
                      child: Text(
                        appLocalization.revoke.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                  )
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }



}