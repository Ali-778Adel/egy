import 'dart:async';

import 'package:fl_egypt_trust/models/entities/branches/branches_model.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/branches/blocs/states.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_pickup_map_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart'as launcher;


class BranchMapWidget extends StatelessWidget {
  final BranchesModel branchData;
  final double lat;
  final double lng;


   BranchMapWidget({Key? key,required this.branchData,required this.lat,required this.lng}) : super(key: key);
  Set<Marker> _markers = {};
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle),
                      ),
                      Text(
                        branchData.address ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: UiConstants.colorTitle),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildMap(context),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        final availableMaps = await launcher.MapLauncher.installedMaps;

                        launcher.AvailableMap? map = availableMaps.isEmpty == true
                            ? null
                            : (availableMaps.length == 1
                                ? availableMaps.first
                                : await BottomSheetPickupMapNavigation.show(
                                    context,
                                    availableMaps: availableMaps));
                        if (map != null) {
                          map.showDirections(
                              destination: launcher.Coords(double.parse(branchData.latitude ?? '0'),
                                  double.parse(branchData.longitude ?? '0')),
                              destinationTitle: branchData.name ?? '');
                        }
                      },
                      icon: const Icon(Icons.near_me_rounded),
                      backgroundColor: UiConstants.colorBabyBlue,
                      label: Text(
                        appLocalization.navigation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  Widget _buildMap(BuildContext context){
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );

    Marker marker = Marker(
      markerId: MarkerId('${branchData.name}'),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: '${branchData.name}', snippet: '${branchData.address}'),
    );
    _markers.add(marker);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: GoogleMap(
          liteModeEnabled: true,
          trafficEnabled: true,
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

}
