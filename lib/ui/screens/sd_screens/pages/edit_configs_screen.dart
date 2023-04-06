
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/buySealPage.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/qr_scanner.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/custom_text_field.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../data/local_data_source/sd.dart';
import '../../../../di/dependency_injection.dart';
import '../../../../models/entities/sd_entities/sd_configs_entity.dart';
import '../../../../models/utils/language/localizations_delegate.dart';
import '../../../../models/utils/themes/colors.dart';
import '../../bottom_navigations/bottom_navigation_handler.dart';
import '../../widgets/bottom_message_confirmation.dart';
import '../../widgets/custom_password_text_field.dart';
import '../../widgets/qr_scan_widget.dart';
import 'edit_qr_scanner.dart';


class ConfigScreenData{
  final String?pinCode;
  final String?secretKey;
  ConfigScreenData({this.pinCode,this.secretKey});
}

ConfigScreenData configScreenData=ConfigScreenData();


class EditSDConfigsScreen extends StatefulWidget {
  const EditSDConfigsScreen({Key? key}) : super(key: key);

  @override
  State<EditSDConfigsScreen> createState() => _EditSDConfigsScreenState();
}

class _EditSDConfigsScreenState extends State<EditSDConfigsScreen> {


  final pinController=TextEditingController();
   String? liecienceCode;
  final secretKeyController=TextEditingController();

  final _formKey=GlobalKey<FormState>();

  String pinCode='';
  String secretKey='';

  bool obsecureBinCode=true;
  bool obsecureSecretKey=true;
bool isCofigs=true;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
checkConfigs().then((value) {
  pinController.text=value.pinCode!;
  secretKeyController.text=value.secretKey!;
  liecienceCode=value.signatureCode;
  print(liecienceCode);

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
                    "${AppGeneralTrans.sdCofigTxt} ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                CustomPasswordTextField(
                  labelHint: AppGeneralTrans.pinTxt,
                  fieldHint: "${AppGeneralTrans.enterTxt } ${AppGeneralTrans.pinTxt}",
                  obsecureText: obsecureBinCode,
                  onIconTapped: (){
                    setState(() {
                      obsecureBinCode=!obsecureBinCode;
                    });
                  },
                  textEditingController: pinController,
                  textFieldTypes: TextFieldTypes.number,
                  onChanged: (val){
                    setState(() {
                      pinCode=val;
                    });
                  },
                  validator: (String?val){
                    if(val==null||val.isEmpty)return AppGeneralTrans.pinValidationTxt;
                    return null;
                  },
                ),
                QrSignatureCustomEditField(
                  fieldLabel: AppGeneralTrans.liecienceTxt,
                  chooseButtonTtx: AppGeneralTrans.qrTxt,
                  licienceName: liecienceCode ,

                ),
                TextButton(onPressed: (){
                  configScreenData=ConfigScreenData(pinCode:pinController.text,secretKey: secretKeyController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQRViewReader()));
                }, child: Text(AppGeneralTrans.qrEditiTxt)),

                CustomPasswordTextField(
                  labelHint: AppGeneralTrans.secretKeyTxtTxt,
                  obsecureText: obsecureSecretKey,
                  onIconTapped: (){
                    setState(() {
                      obsecureSecretKey=!obsecureSecretKey;
                    });
                  },
                  fieldHint: "${AppGeneralTrans.enterTxt } ${AppGeneralTrans.secretKeyTxtTxt}",
                  textEditingController: secretKeyController,
                  textFieldTypes: TextFieldTypes.number,
                  onChanged: (val){
                    secretKey=val;
                  },
                  validator: (String?val){
                    if(val==null||val.isEmpty)return AppGeneralTrans.secretValidationTxt;
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
                        if(_formKey.currentState!.validate() ){
                          await sl<SDLocalData>().setSDConfigsData(sdConfigsEntity: SdConfigsEntity(
                              pinCode: pinController.text,
                              signatureCode: editQRViewArgs.signature??liecienceCode,
                              secretKey: secretKeyController.text
                          )).then((value){
                            debugPrint("config data saved successfully");
                            showToastWidget( CustomToastWidget(toastContent:"تم تعديل البيانات بنجاح ",toastStatus: ToastStatus.success,),position: ToastPosition.center);

                            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BuySealPage()), (route) => false);
                          });
                          // sendDataToNaitve(signature: qrArgs.signature!,pinCode: pinController.text);

                        }else{
                          showToastWidget( CustomToastWidget(toastContent: AppGeneralTrans.dataRequirementValidationTxt,toastStatus: ToastStatus.error,),position: ToastPosition.bottom);
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
                      child:  Text(
                        AppGeneralTrans.editTxt,
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

    return pinController.text.isEmpty == true
        || liecienceCode==null
        || secretKeyController.text.isEmpty == true;

  }

}
