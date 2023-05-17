import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/local_data_source/sd.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../../../models/utils/dimens.dart';
import '../../../../models/utils/themes/app_general_trans.dart';
import '../../../../models/utils/themes/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/toast_widget.dart';
import 'configs_screen.dart';

class ExtractSignaturePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExtractSignaturePage();
  }
}

class _ExtractSignaturePage extends State<ExtractSignaturePage> {
  TextEditingController userDataController=TextEditingController();
  bool isSealRequested=false;
  bool isConfigs=false;
  String signature="";
  String pinCode="";
  Map<String,dynamic>certificateData={};



  Future<SdConfigsEntity>checkConfigs()async{
    final either= await sl<SDLocalData>().getSDConfigsData();
    return either.fold((l) {
      setState(() {
        isConfigs=false;
      });
      return SdConfigsEntity();
    }, (r) {
      setState(() {
        isConfigs=true;
      });
      return r;
    });
  }
  Future<void> call({
    required String signature,required String pinCode,required String userData})
  async {
    const channel = MethodChannel('com.example.native_method_channel');
    await channel.invokeMethod('onCreate1',{'signature':signature,'pinCode':pinCode,'userData':userData}).then((value) {
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

        // valFromNative =value.toString();
      });
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConfigs().then((value) {
      signature=value.signatureCode??'';
      pinCode=value.pinCode??'';

    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: null,
              controller: userDataController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 10.0),

        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
        hintText:  "ادخل بياناتك",
        isDense: true,
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(Dimens.space4),
          borderSide:  BorderSide(color: Palette.disable),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(Dimens.space4),
          borderSide:  BorderSide(color: Palette.mainBlue),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(Dimens.space4),
          borderSide:  BorderSide(color: Palette.colorRed),
        ),
      ),
            ),
            Center(child:
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.sp),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 12.sp),
                child: SizedBox(
                  // height: 30.sp,
                  width: 60.w,
                  child: TextButton(
                    onPressed: ()async{
                      if(userDataController.text.isEmpty){
                        showToastWidget(
                            const CustomToastWidget(
                              toastContent:"يرجي إدخال بياناتك اولا ",
                              toastStatus: ToastStatus.error,
                            ),
                            position: ToastPosition.bottom);
                      }else{
                        setState(() {
                          isSealRequested=true;
                        });
                      }

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
            if(isSealRequested)
              FutureBuilder(
                  future: call(signature: signature!, pinCode: pinCode!, userData: userDataController.text),
                  builder: (context,snapShot){
                if(snapShot.connectionState==ConnectionState.waiting){
                  return const Center(child:CircularProgressIndicator(),);
                }else if(snapShot.hasError){
                  return Text("error");
                }else{
                  return Container(
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
                          data: certificateData['key5'],
                          version: QrVersions.auto,
                          size: 200.0,
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                        ),
                      )

                  );

                }
              })
          ],
        ),
      ),
    );
  }
}
