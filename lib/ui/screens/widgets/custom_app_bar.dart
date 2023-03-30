import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../di/dependency_injection.dart';
import '../../../models/utils/themes/colors.dart';


class CustomAppBar {
  BuildContext context;
  final String?pageTitle;
  final Function()?onPop;
  CustomAppBar({required this.context,this.pageTitle,this.onPop});
  PreferredSizeWidget call() {
    return PreferredSize(
      preferredSize: Size(SizerUtil.width, 104.sp),
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical:8.sp,horizontal: 16.sp),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.sp),
              height: 80.sp,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildLeading(context),
                      Spacer(),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          height: 35.sp,
                          width: 94.sp,
                          child: Image.asset(
                            'assets/drawable/titleLogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                    ],
                  ),

                  if(pageTitle!=null)
                  Row(children: [
                    IconButton(onPressed: onPop??()=>Navigator.of(context),
                        icon: Icon(Icons.arrow_back,color: Palette.black,)),
                    Text('$pageTitle',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),),
                  ],)
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserName(),
      builder: (context, snapshot ) {
        return Wrap(

          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            _buildImageAvatar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Text(
                '${AppGeneralTrans.welcomeTxt}  '
                    '${snapshot.data}'
                ,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Tajawal',
                    fontSize: 16.sp),
              ),
            )
          ],
        );
      }
    );
  }

  Widget _buildImageAvatar() {
    return Container(
      height: 34.sp,
      width: 34.sp,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Palette.mainBlue, width: 2)),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 17.sp,
        child: CachedNetworkImage(
          imageUrl: AppIcons.userIconUrl,
          height: 30.sp,
          width: 23.sp,
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) =>const Icon(Icons.error),
        ),
      ),
    );
  }

  Future<String> getUserName()async{
    final data =await sl<AppPreference>().getUserData();
    if(data!=null){
      final username =data.userFullName;
      final firstname=username!.substring(0,username.indexOf(' '));
      print('************************************************username:$username');
      print('************************************************username:$firstname');
      return firstname;
    }else{
      return '';
    }


  }

}
