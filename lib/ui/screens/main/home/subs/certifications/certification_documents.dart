import 'dart:convert';

import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/entities/public_entities/document_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/models/utils/utilities.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_pickup_type.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../models/entities/public_entities/certification_type_model.dart';

class CertificationDocumentsView extends StatefulWidget {
  final CertificationTypeModel selectedCertification;
  final List<DocumentModel> documents;
  final bool disableActions;

  const CertificationDocumentsView(
      {Key? key,
      required this.selectedCertification,
      required this.documents,
      required this.disableActions})
      : super(key: key);

  @override
  _CertificationDocumentsView createState() => _CertificationDocumentsView();
}

class _CertificationDocumentsView extends State<CertificationDocumentsView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IgnorePointer(
      ignoring: widget.disableActions == true,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedCertification.requiredDocumentsNote ?? '',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: UiConstants.colorTitle),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        print(
                            'the sample document link : ${widget.selectedCertification.sampleDownloadLink}');
                        if (await canLaunch(
                            widget.selectedCertification.sampleDownloadLink ??
                                '')) {
                          launch(
                              widget.selectedCertification.sampleDownloadLink ??
                                  '');
                        }
                      },
                      child: Text(
                        appLocalization.view.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Palette.mainBlue),
                      ))
                ],
              ),
              ListView.builder(
                  itemCount: widget.documents.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _buildImage(widget.documents[index],
                        canDelete: index != 0 || widget.documents.length > 1);
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.documents.add(DocumentModel());
                      });
                    },
                    child: Text(
                      appLocalization.addAnotherDocument.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 45)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            UiConstants.colorBabyBlue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: UiConstants.colorBabyBlue)))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(DocumentModel doc, {bool canDelete = true}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: Palette.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () async {
                var file = await BottomSheetPickupType.pickFile(context);
                if (file != null) {
                  var uint8List = await file.readAsBytes();

                    setState(() {
                      doc.error = null;
                      doc.oRDBase64Doc = base64.encode(uint8List.toList());
                      doc.isImage = Utilities.isImage(file.path);
                      doc.filePath = file.path;
                    });

                }
              },
              child: Ink.image(
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                image: doc.oRDBase64Doc != null
                    ? (doc.isImage
                        ? Image.memory(
                            base64.decode(doc.oRDBase64Doc ?? ''),
                            errorBuilder: (_, ob, trace) {
                              logger.e(ob);
                              return Image.asset(
                                  'assets/drawable/ic_doc_placeholder.png');
                            },
                          ).image
                        : const AssetImage('assets/drawable/ic_doc_placeholder.png'))
                    : const AssetImage(
                        'assets/drawable/ic_document_placeholder.png'),
              ),
            ),
          ),
        ),
        if (doc.error != null &&
            doc.error?.isNotEmpty == true &&
            doc.oRDBase64Doc != null &&
            doc.oRDBase64Doc?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: double.infinity,
              height: 50,
              color: UiConstants.colorErrorDocumentBackground,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            initialValue: doc.oRDName,
            onChanged: (value) {
              if (doc.error != null) {
                setState(() {
                  doc.error = null;
                });
              }
              doc.oRDName = value;
            },
            maxLength: 20,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.black),
            decoration: InputDecoration(
              errorText: doc.error,
              labelText: appLocalization.documentNameRequired,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: UiConstants.colorTextFieldEnabledUnderline),
              ),
            ),
          ),
        ),
        if (canDelete == true || doc.oRDBase64Doc != null)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: UiConstants.colorCertificationCard.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.documents.length == 1) {
                          widget.documents.add(DocumentModel());
                        }

                        widget.documents.remove(doc);
                      });
                    },
                    icon: const Icon(Icons.close,
                        size: 20, color: UiConstants.colorRed),
                  )),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
