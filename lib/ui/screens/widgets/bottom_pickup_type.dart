


import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/utils/themes/colors.dart';
import 'bottom_message_confirmation.dart';
import 'package:app_settings/app_settings.dart';


class BottomSheetPickupType extends StatelessWidget{
  const BottomSheetPickupType({Key? key}) : super(key: key);



  static Future<File?> pickFile(BuildContext context)async{
    var type =  await showModalBottomSheet<_PickType>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10) , topLeft: Radius.circular(10)),
      ),
      context: context,
        isScrollControlled: true,
      builder: (BuildContext context) {
        return const BottomSheetPickupType();
      },
    );

    try {
      if (type == _PickType.camera) {
        final XFile? photo = await ImagePicker().pickImage(
            source: ImageSource.camera, imageQuality: 80);

        if (photo != null) {
          File file = File(photo.path);
          return file;
        }
      } else if (type == _PickType.image) {
        final XFile? photo = await ImagePicker().pickImage(
            source: ImageSource.gallery, imageQuality: 80);

        if (photo != null) {
          File file = File(photo.path);
          return file;
        }
      } else if (type == _PickType.file) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc', 'docx']
        );

        if (result != null) {
          File file = File(result.files.single.path ?? '');
          return file;
        }
      }
    }catch(ex){
      if(ex is PlatformException){
        BottomSheetMessageConfirmation.show(
          context,
          initTime : 0,
          title: appLocalization.permissionsDeniedTitle,
          message: appLocalization.permissionsDeniedMessage,
          positiveText: appLocalization.settings,
          onPositiveTap: (){

            AppSettings.openAppSettings();
          },
        );
      }
    }
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
            appLocalization.pickTypeTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: UiConstants.colorTitle),
          ),
        ),

        _buildAction(context: context , icon: Icons.camera, title: appLocalization.camera, onTap: (){
          Navigator.of(context).pop(_PickType.camera);
        }),

        _buildAction(context: context , icon: Icons.image, title: appLocalization.gallery, onTap: (){
          Navigator.of(context).pop(_PickType.image);
        }),

        _buildAction(context : context ,icon: Icons.attach_file, title: appLocalization.fileManager, onTap: (){
          Navigator.of(context).pop(_PickType.file);
        }),
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

  _buildAction({required BuildContext  context,required IconData icon ,required String title  ,required VoidCallback onTap}){
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
                  child: Icon(icon , color: UiConstants.colorTitle,),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                      child:  Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
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

enum _PickType {
  camera , image, file
}