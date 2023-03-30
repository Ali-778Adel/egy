import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomServiceItem extends StatelessWidget {
  final String?serviceName;
  final IconData iconData;
  final String imageUrl;
  final Function()onTap;
  const CustomServiceItem({Key? key,required this.serviceName,required this.imageUrl,required this.iconData,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.sp),
          padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical:8.sp ),
          width: double.infinity,
          height: 46.sp,
          decoration:const BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
              boxShadow: [BoxShadow(
                  color:  Color(0xffd9d9d9),
                  offset: Offset(0,0),
                  blurRadius: 4,
                  spreadRadius: 0
              )] ,
              color:  Color(0xffffffff)
          ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 16.sp,
              width: 16.sp,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>const Icon(Icons.error),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Text(
              serviceName??'',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
             fontSize: 14.sp,
             fontWeight: FontWeight.w600,
              color: Palette.textHint,
              fontStyle:  FontStyle.normal,

            ),
            ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,size: 16.sp,color: Palette.textHint,)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
