import 'package:fl_egypt_trust/ui/screens/main/redesign_home/pages/buySealPage.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/qr_scanner.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_text_field.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/local_data_source/sd.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../../../models/utils/language/localizations_delegate.dart';
import '../../../../models/utils/themes/colors.dart';
import '../../bottom_navigations/bottom_navigation_handler.dart';
import '../../widgets/bottom_message_confirmation.dart';
import '../../widgets/qr_scan_widget.dart';

class SDConfigsScreen extends StatefulWidget {
  const SDConfigsScreen({Key? key}) : super(key: key);

  @override
  State<SDConfigsScreen> createState() => _SDConfigsScreenState();
}

class _SDConfigsScreenState extends State<SDConfigsScreen> {


  final pinController=TextEditingController();
  final signatureController=TextEditingController();
  final secretKeyController=TextEditingController();

  final _formKey=GlobalKey<FormState>();

  String pinCode='';
  String secretKey='';

   sendDataToNaitve({required String signature,required String pinCode})async{
     const channel = MethodChannel('configs_channel');
   await channel.invokeMethod('getConfigs',{'signature':signature,'pinCode':pinCode}).then((value){
     print ("value from native is ${value.toString()}");
   });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController.text=pinCode;
    secretKeyController.text=secretKey;

  }

  @override
  Widget build(BuildContext context) {
    // final  args=ModalRoute.of(context)!.settings.arguments as QRViewArgs;
    return WillPopScope(
      onWillPop: ()async{
        _popup();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(context: context).call(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.sp),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(padding:EdgeInsets.symmetric(vertical: 8.sp),
                  child: Text(
                    "ليس لديك بيانات مسجله لدينا يرجي ادخال البيانات التالية لتتمكن من استخراج التوقيع الخاص بك عن طريق البطاقة الموجودة على هاتفك ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                CustomTextField(
                  labelHint: "PIN",
                    fieldHint: "ادخل ال PIN الخاص بك ",
                    textEditingController: pinController,
                    textFieldTypes: TextFieldTypes.number,
                  onChanged: (val){
                    setState(() {
                      pinCode=val;
                    });
                  },
                  validator: (String?val){
                      if(val==null||val.isEmpty)return "من فضلك ادخل ال pin الخاص بك";
                      return null;
                  },
                ),
                QrSignatureCustomField(
                  fieldLabel: 'رقم التوقيع',
                  onPickTapped: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewReader()));
                  },
                  chooseButtonTtx:  ' امسح ال QR CODE',
                  licienceName: qrArgs.signature== null ? '' :qrArgs.signature ,

                ),

                CustomTextField(
                  labelHint: "الرقم السري",
                    fieldHint: "ادخل الرقم السري  الخاص بك ",
                    textEditingController: secretKeyController,
                    textFieldTypes: TextFieldTypes.number,
                  onChanged: (val){
                    secretKey=val;
                  },
                  validator: (String?val){
                      if(val==null||val.isEmpty)return "من فضلك ادخل الرقم السري";
                      return null;
                  },
                ),

                Center(child:
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 12.sp),
                  child: SizedBox(
                    height: 30.sp,
                    width: 60.w,
                    child: TextButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate() && qrArgs.signature!=null){
                          await sl<SDLocalData>().setSDConfigsData(sdConfigsEntity: SdConfigsEntity(
                            pinCode: pinController.text,
                            signatureCode: qrArgs.signature,
                            secretKey: secretKeyController.text
                          )).then((value){
                            debugPrint("config data saved successfully");
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BuySealPage()), (route) => false);
                          });
                          // sendDataToNaitve(signature: qrArgs.signature!,pinCode: pinController.text);

                        }else{
                          showToastWidget(const CustomToastWidget(toastContent: "يجب ادخال جميع البيانات المطلوبة",toastStatus: ToastStatus.error,),position: ToastPosition.bottom);
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
                      child:const  Text(
                        "حفظ",
                        style:  TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _popup()async{
    FocusScope.of(context).requestFocus(FocusNode());
    if(_showDiscard() == true){
      await BottomSheetMessageConfirmation.show(
        context,
        initTime : 0,
        title: appLocalization.unsavedChangesTitle,
        message: appLocalization.unsavedChangesMessage,
        positiveText: appLocalization.discard,
        onPositiveTap: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeNavigationScreen()), (route) => false);
        },
      );
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeNavigationScreen()), (route) => false);
  }

  bool _showDiscard() {

    return pinController.text.isNotEmpty == true
        || qrArgs.signature == null
        || secretKeyController.text.isNotEmpty == true;

  }

}
