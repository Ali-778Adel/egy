



import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../models/utils/themes/colors.dart';

class BottomSheetPickupMapNavigation extends StatelessWidget{
  final List<AvailableMap> availableMaps;
  const BottomSheetPickupMapNavigation({Key? key , required this.availableMaps}) : super(key: key);



  static Future<AvailableMap?> show(BuildContext context , {required List<AvailableMap> availableMaps})async{
    return await showModalBottomSheet<AvailableMap>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10) , topLeft: Radius.circular(10)),
      ),
      context: context,
        isScrollControlled: true,
      builder: (BuildContext context) {
        return  BottomSheetPickupMapNavigation(availableMaps: availableMaps,);
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Text(
            appLocalization.pickMapTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: UiConstants.colorTitle),
          ),
        ),

        ...availableMaps.map((e) =>
            _buildAction(context: context , icon: e.icon, title: e.mapName, onTap: (){
          Navigator.of(context).pop(e);
        }),),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(appLocalization.cancel.toUpperCase(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 45)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      UiConstants.colorRed),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                              color: UiConstants.colorRed)))),
            ),
          ),
        ),
      ],
    );
  }

  _buildAction({required BuildContext context ,required String icon ,required String title  ,required VoidCallback onTap}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5 , horizontal: 1),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
                minHeight: 60),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(icon ,width: 40, height: 40,),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                      child:  Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: UiConstants.colorTitle),
                      ),
                    )
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

}
