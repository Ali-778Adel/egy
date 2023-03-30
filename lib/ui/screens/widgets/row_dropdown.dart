

import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';

import '../../../models/utils/themes/colors.dart';

class RowDropdown extends Text{
  final String label;
      RowDropdown({Key? key, required this.label}) : super(
         label,
        key: key,
          maxLines: 1,
          style:  TextStyle(fontFamily: 'Tajawal',color: Palette.black),
       overflow: TextOverflow.ellipsis,

    );


}