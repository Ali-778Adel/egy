


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:mime/mime.dart';


class Utilities {


  static openWhatsApp(BuildContext context , String phone , {String? whatsAppNotInstalled , String? initialMessage})async{

    final link = WhatsAppUnilink(
      phoneNumber: phone,
      text: initialMessage,
    );

    print('send whatsApp : $link');

    if( (await canLaunch('$link')) == true){
      await launch('$link');
    }
    else if(whatsAppNotInstalled?.isNotEmpty == true){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(whatsAppNotInstalled ?? '')));
    }


  }

  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType?.startsWith('image/') ?? false;
  }
}