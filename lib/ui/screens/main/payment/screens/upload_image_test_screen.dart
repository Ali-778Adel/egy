import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/data/services/dio/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/pickup_file_field.dart';

class UploadImageScreen extends StatefulWidget {

   String issuanceName='';
   String issuancePath='';

   UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child:   PickUpFileField(
              chooseButtonTtx:'اختر ملف',
              fieldLabel: ' طلب الاصدار ( صورة )',
              fileName: widget.issuanceName,
              onPickTapped: () {
                pickImage();
              },
            ),
          ),
          Center(
            child: TextButton(onPressed: () {
              uploadImage();
            }, child:const Text('pickImage'),),
          )
        ],
      ),
    );
  }

  Future<void>pickImage()async{
    await ImagePicker.platform.getImage(source: ImageSource.gallery).then((value) {
      setState(() {
        widget.issuanceName=value!.name;
        widget.issuancePath=value.path;
      });
    });
  }

  Future<void>uploadImage()async{
    try{
      FormData formData=FormData.fromMap(
          {
        "services":1,
        "serviceStatus":1,
        "states":101,
        "cities":202,
        "address":'address',
        "cardId":'21123131',
        "email":'aaaaa@yahoo.com',
        "mobile":'01010665256',
        "comcompany":'alaaco',
        "comorderCount":1,
        "isTherediscount":true,
        "facebook":'sjh',
        "whast":'dsjhd',
        "comSubscriptionId":1,
        'comdiscount':'12',
        "total":1000,
        "isCommissioner":'string',
        "commissioner":'string',
        "commissionerMobile":'string',
        "commissionerCardId":'string',
        "issuanceTaxDate":'5/10/2023',
        "taxCardDate":'5/5/2023',
        "discountUpload":true,
        "liberalProfessions":true,
        "companyfiles":
          await MultipartFile.fromFile(widget.issuancePath,
              filename:'companyfiles_1.png',
          headers: {
            'Content-Type':[
              'multipart/form-data'
            ]
          }
          )
        ,
        "personalfiles":
          await MultipartFile.fromFile(widget.issuancePath,
              filename: 'personalfiles_1.jpg',
              headers: {
              'Content-Type':[
              'multipart/form-data'
              ]
              }
          )
        ,
        "commissionerfiles":
          await MultipartFile.fromFile(widget.issuancePath,
              filename: 'commissionerfiles_0.jpg',
              headers: {
                'Content-Type':[
                  'multipart/form-data'
                ]
              }
          )
      }
      );
      await sl<DioClientService>().postForms(url: 'EgyptTrustUsers', data:formData);
    }catch(e){
     debugPrint('error in upload photo $e');
    }
  }
}
