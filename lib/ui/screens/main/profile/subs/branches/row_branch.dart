import 'package:fl_egypt_trust/models/entities/branches/branches_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_pickup_map_navigation.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../models/entities/public_entities/branch_model.dart';

class RowBranch extends StatelessWidget {
  final BranchesModel branchData;

  const RowBranch({Key? key, required this.branchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on_rounded),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branchData.address ?? '',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle),
                      ),
                      Text(
                        branchData.address ?? '',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: UiConstants.colorTitle),
                      ),
                    ],
                  )),
                  // IconButton(
                  //     onPressed: () async {
                  //       String phone = 'tel:${branchData.phoneNumber}';
                  //       if ((await canLaunch(phone)) ==
                  //           true) {
                  //         launch(phone);
                  //       }
                  //     },
                  //     icon: const Icon(
                  //       Icons.call,
                  //       color: UiConstants.colorPrimary,
                  //     ))
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                FadeInImage.assetNetwork(
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: branchData.map ?? '',
                  placeholder: 'assets/drawable/ic_document_placeholder.png',
                  imageErrorBuilder: (_, __, ___) {
                    return Image.asset(
                        'assets/drawable/ic_document_placeholder.png');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        final availableMaps = await MapLauncher.installedMaps;

                        AvailableMap? map = availableMaps.isEmpty == true
                            ? null
                            : (availableMaps.length == 1
                                ? availableMaps.first
                                : await BottomSheetPickupMapNavigation.show(
                                    context,
                                    availableMaps: availableMaps));
                        if (map != null) {
                          map.showDirections(
                              destination: Coords(double.parse(branchData.latitude ?? '0'),
                                  double.parse(branchData.longitude ?? '0')),
                              destinationTitle: branchData.name ?? '');
                        }
                      },
                      icon: const Icon(Icons.near_me_rounded),
                      backgroundColor: UiConstants.colorBabyBlue,
                      label: Text(
                        appLocalization.navigation,
                        style: Theme.of(context).textTheme.button?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
