import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';



class ShimmerHomeScreen extends StatelessWidget{
  const ShimmerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
             SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    loop: 50,
                      child: _buildCarousel()),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      loop: 50,
                      child: _buildServicesSection()),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      loop: 50,
                      child: _buildContactUsLabel()),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      loop: 50,
                      child: _buildSocialSection()),

                ],
              ),
            )

    );
  }
  /// build carousel
  Widget _buildCarousel() {
    return Container(
        height: 180.sp,
        width: double.infinity,
        decoration: BoxDecoration(
          color:const Color(0xff808080),
          borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        ),
        );
  }

  /// build services
  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.sp, bottom: 16.sp),
          child: Text(
            "الخدمات",
            style: TextStyle(
                color: const Color(0xa6000000),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                fontStyle: FontStyle.normal,
                fontSize: 16.0.sp),
            // textAlign: TextAlign.center
          ),
        ),
         _buildShimmerContainer(),
        _buildShimmerContainer(),
        _buildShimmerContainer()
      ],
    );
  }

  /// build contactUs label
  Widget _buildContactUsLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0x75285397)))),
          Expanded(
              child: Text("تواصل معنا",
                  style: TextStyle(
                      color: const Color(0xa6000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0.sp),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Container(
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0x75285397)))),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        children: [
          Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Unicon(
                  Unicons.uniWhatsappAlt,
                  size: 20.sp,
                ),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Unicon(
                  Unicons.uniInstagramAlt,
                  size: 20.sp,
                ),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Unicon(
                  Unicons.uniFacebook,
                  size: 20.sp,
                ),
              )),
          Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Unicon(
                  Unicons.uniTwitter,
                  size: 20.sp,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer(){
    return   Container(
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

    );
  }
}