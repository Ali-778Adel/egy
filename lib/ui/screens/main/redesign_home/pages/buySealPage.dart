import 'dart:io';

import 'package:fl_egypt_trust/data/local_data_source/sd.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../di/dependency_injection.dart';
import '../../../../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../../../../models/utils/language/localizations_delegate.dart';
import '../../../sd_screens/pages/configs_screen.dart';
import '../../../widgets/bottom_message_confirmation.dart';

class BuySealPage extends StatefulWidget {
  const BuySealPage({Key? key}) : super(key: key);

  @override
  State<BuySealPage> createState() => _BuySealPageState();
}

class _BuySealPageState extends State<BuySealPage> {
  bool isCofigs=false;
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

  String valFromNative='';

  Future<void> call({required String signature,required String pinCode}) async {
    const channel = MethodChannel('com.example.native_method_channel');


    await channel.invokeMethod('onCreate1',{'signature':signature,'pinCode':pinCode}).then((value) {
      print("value form b=native is ${value.toString()}");
      setState(() {
        valFromNative =value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(context: context).call(),
        body: Container(
          child: Center(
            child: Text(valFromNative,style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ),
      ),
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


}
