


import 'package:flutter/material.dart';


class CertificationKeyAssetChecker{


  static IconData getAssetPath(String? key){
    switch(key?.toLowerCase()){
      case 'email':
      case 'e':
        return Icons.email;
      case 'expiry date':
        return Icons.date_range;
      case 'cn':
      case 'company name':
        return Icons.business_center;
      case 'issued by':
        return Icons.account_box;
      default:
        return Icons.graphic_eq;
    }
  }
}