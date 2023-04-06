import 'dart:io';

import 'package:fl_egypt_trust/data/local_data_source/sd.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../../../models/utils/themes/colors.dart';
import 'configs_screen.dart';
import 'edit_configs_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';


class BuySealPage extends StatefulWidget {
  const BuySealPage({Key? key}) : super(key: key);

  @override
  State<BuySealPage> createState() => _BuySealPageState();
}

class _BuySealPageState extends State<BuySealPage> {
  bool isCofigs=false;

  String input = '';
  Map<String, String> result = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConfigs().then((value) {
      if(value.signatureCode==null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SDConfigsScreen()));
      }else{
        call(signature: value.signatureCode??'',pinCode: value.pinCode??'');
      }

    });

    // if(valFromNative!="");


  }

  Future<SdConfigsEntity>checkConfigs()async{
   final either= await sl<SDLocalData>().getSDConfigsData();
   return either.fold((l) {
     setState(() {
           isCofigs=false;
     });
     return SdConfigsEntity();
   }, (r) {
     setState(() {
       isCofigs=true;
     });
     return r;
   });
  }

  // String valFromNative='';
    Map<String,dynamic>certificateData={};
    bool isSealRequested=false;

  Future<void> call({required String signature,required String pinCode}) async {
    const channel = MethodChannel('com.example.native_method_channel');
    await channel.invokeMethod('onCreate1',{'signature':signature,'pinCode':pinCode}).then((value) {
      print("value form b=native is ${value.toString()}");
      setState(() {
        Map<Object?, Object?> originalMap = value;
        Map<String, dynamic> newMap = {};

        originalMap.forEach((key, value) {
          if (key is String) {
            newMap[key] = value;
          }
        });

         certificateData = newMap ;
         input=certificateData['key6'];
        List<String> pairs = input.split(', ');
        for (String pair in pairs) {
          List<String> keyValue = pair.split('=');
          result[keyValue[0]] = keyValue[1];
        }
        print(result);


        print("${certificateData}");
        // valFromNative =value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CustomAppBar(context: context).call(),
        body:SingleChildScrollView(
          padding: EdgeInsets.all(16.sp),
          child: _buildSDData(context: context),
        ),
         floatingActionButton: Visibility(
             visible: isCofigs,
             child: FloatingActionButton(onPressed: () {  },
           child: IconButton(icon: const Icon(Icons.settings), onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditSDConfigsScreen()));
           },),)),
      );


  }

  Future<File> getFileFromSDCard(String fileName) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';
    return File(filePath);
  }

  Future<String> readFileFromSDCard(String fileName) async {
    try {
      final file = await getFileFromSDCard(fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }


  Widget _buildSDData({required BuildContext context}){

    if(
        certificateData["key2"].toString().isNotEmpty
        &&
        certificateData["key5"].toString().isNotEmpty
    ){
      return Column(
        children: [
          Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                border: Border.all(color: Palette.mainGreen)

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(flex:4,child: Text(AppGeneralTrans.egyTrustTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32.sp,color: Palette.mainGreen),)),
                      Expanded(flex:1, child: Icon(Icons.sd,color: Palette.mainGreen,size: 32.sp,))
                    ],
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.sp),
                    child: Wrap(
                      children: [
                        Text(AppGeneralTrans.serialNumTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),),
                         Text(
                           "${certificateData["key2"].toString().isEmpty ?AppGeneralTrans.waitTxt:certificateData["key2"]}",
                           style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),)
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),

                  /// start of user data
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex:1,child: Text(AppGeneralTrans.companyTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),)),
                        Expanded(flex:4,child: Text(
                          "${result['key6'].toString().isEmpty?AppGeneralTrans.waitTxt:AppGeneralTrans.egyTrustTxt}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),))
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex:2,child: Text(AppGeneralTrans.emailTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),)),
                        Expanded(flex:5,child: Text(
                          "${certificateData['key6'].toString().isEmpty?AppGeneralTrans.waitTxt:result['EMAILADDRESS']}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),))
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex:1,child: Text(AppGeneralTrans.client,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),)),
                        Expanded(flex:4,child: Text(
                          "${certificateData['key6'].toString().isEmpty?AppGeneralTrans.waitTxt:result['O']}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),))
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex:2,child: Text(AppGeneralTrans.natiionalIdTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),)),
                        Expanded(flex:5,child: Text(
                          "${certificateData['key6'].toString().isEmpty?AppGeneralTrans.waitTxt:result['OU']}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),))
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex:2,child: Text(AppGeneralTrans.VategTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),)),
                        Expanded(flex:5,child: Text(
                          "${certificateData['key6'].toString().isEmpty?AppGeneralTrans.waitTxt:result['OID.2.5.4.97']}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),))
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),


                  /// end of user data
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.sp),
                    child: Wrap(
                      children: [
                        Text(AppGeneralTrans.certStartDateTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen),),
                        Text(
                          "${certificateData["key3"].toString().isEmpty?AppGeneralTrans.waitTxt:certificateData['key3']}"
                          ,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue),)
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.sp),
                    child: Wrap(

                      children: [
                        Text(AppGeneralTrans.certEndDateTxt,style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainGreen,),),
                        Text(
                          "${certificateData["key4"].toString().isEmpty?AppGeneralTrans.waitTxt:certificateData["key4"]}",
                          style:   Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.mainBlue,),)
                      ],
                    ),
                  ),
                  Divider(color: Palette.mainGreen,height: 2.sp,),

                ],
              )
          ),
          Center(child:
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.sp),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 12.sp),
              child: SizedBox(
                height: 30.sp,
                width: 60.w,
                child: TextButton(
                  onPressed: ()async{
                    setState(() {
                      isSealRequested=true;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Palette.mainGreen),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(
                          Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(35.0),
                              side:
                              BorderSide(color: Palette.mainGreen)))),
                  child:   Text(
                    AppGeneralTrans.showSignatureTxt,
                    style:const  TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),),


          if(isSealRequested==true)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(32.sp),
            margin: EdgeInsets.symmetric(vertical: 16.sp),

            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              border: Border.all(color: Palette.textHint),
            ),
            child:Center(
              child: QrImage(
                data: "${certificateData['key5']}",
                version: QrVersions.auto,
                size: 200.0,
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
              ),
            )

          )



        ],
      );
    }else{
      return Center(
        child: Text(certificateData["key1"].toString()),);
    }

  }

}
