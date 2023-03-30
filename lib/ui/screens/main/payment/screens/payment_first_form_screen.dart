import 'package:fl_egypt_trust/models/entities/payment_entities/payment_first_screen_model.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_general_trans.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/bloc/payment_second_form_bloc/events.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import '../../../../../data/services/dio/dio_client.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/entities/home_entities/home_translator_entity.dart';
import '../../../../../models/utils/themes/themes_bloc/bloc.dart';
import '../../../../../repository/common_function/handle_dio_error_excptions.dart';
import '../../../widgets/connection_error widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/cutom_buttons.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/toast_widget.dart';
import '../bloc/payment_first_form_bloc/bloc.dart';
import '../bloc/payment_first_form_bloc/events.dart';
import '../bloc/payment_first_form_bloc/states.dart';
import '../bloc/payment_second_form_bloc/bloc.dart';

class FirstScreenArgs {
  final bool? isSignutre;
  final int?serviceId;
  final int?serviceStatusId;
  FirstScreenArgs({this.isSignutre,this.serviceId,this.serviceStatusId});
}
 PaymentFirstScreenModel paymentFirstScreenModel=PaymentFirstScreenModel();


class PaymentFirstFormScreen extends StatefulWidget {
  const PaymentFirstFormScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentFirstFormScreen();
  }
}

class _PaymentFirstFormScreen extends State<PaymentFirstFormScreen> {
  String selectedType = '';
  String selectedStatus = '';
  int serviceId=0;
  int serviceStatusId=0;
  bool isSigniture = false;


  List<PublicTranslatorEntity> trans = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PaymentFirstFormBloc>(context).add(GetFirstFormDataEvent());
  }
  String appLocal=sl<ThemeBloc>().appLocal;
  String getTrans({required  GetFirstFormDataStates state,required String txtKey}){
    if(appLocal=='ar-SA'){
      return "${state.publicTranslatorEntity!.where((element) => element.key == txtKey).first.val}";
    }else if(appLocal=='en-US'){
      return "${state.publicTranslatorEntity!.where((element) => element.key == txtKey).first.valEn}";
    }else{
      return "لا يوجد نص";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(context: context).call(),
        body: BlocConsumer<PaymentFirstFormBloc,PaymentFirstFormStates>(
          builder: (context, state) {
            if (state is GetFirstFormDataStates) {
              if (state.firstFormStatus == FirstFormStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.firstFormStatus == FirstFormStatus.error) {
                return Center(
                    child: RetryContainer(
                  onRetry: () {
                    BlocProvider.of<PaymentFirstFormBloc>(context)
                        .add(GetFirstFormDataEvent());
                  },
                  errorMessage: sl<DioErrorsImpl>().dioErrorMessage,
                ));
              }
              if (state.firstFormStatus == FirstFormStatus.success) {
                return _buildBody(state);
              }
            }
            return Container();
          },
          listener: (context, state) {
            if (state is GetFirstFormDataStates) {
              switch (state.firstFormStatus) {
                case FirstFormStatus.loading:
                  {
                    // showToastWidget(CustomToastWidget(
                    //   toastContent: state.message,
                    //   toastStatus: ToastStatus.warning,
                    // ));
                  }
                  break;
                case FirstFormStatus.error:
                  {
                    showToastWidget(
                        CustomToastWidget(
                          toastContent: state.message,
                          toastStatus: ToastStatus.error,
                        ),
                        position: ToastPosition.bottom);
                  }
                  break;
                case FirstFormStatus.success:
                  {
                    trans = state.publicTranslatorEntity!;
                    debugPrint(state.message);
                  }
                  break;
                default:
                  {
                    debugPrint('default');
                  }
              }
            }
          },
        ));
  }

  bool checkValidate() {
    if (selectedType.isNotEmpty && selectedStatus.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildBody(GetFirstFormDataStates state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 0.sp),
            child: Text(
             getTrans(state: state, txtKey: 'headerTxt'),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold,height: 2.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 16.sp),
            child: Text(
               getTrans(state: state, txtKey: 'header2Txt')
                 ,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.sp),
            child: DropDown(
              hint:getTrans(state: state, txtKey: 'serviceTypeTxt'),
              items: state.paymentServiceTypeModels!
                  .map((value) => DropdownMenuItem(
                      value: value, child: Text(value.serviceName!)))
                  .toList(),
              hintIsVisible: true,
              onChanged: (val) {
                setState(() {
                  selectedType = val.serviceName!;
                  serviceId=val.serviceId;
                  if (val.serviceId == 2) {
                    isSigniture = true;
                  } else {
                    isSigniture = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sp),
            child: DropDown(
              hint:getTrans(state: state, txtKey: 'serviceStatusTxt'),
              items: state.paymentServiceStatusModels!
                  .map((value) => DropdownMenuItem(
                      value: value, child: Text(value.serviceName!)))
                  .toList(),
              hintIsVisible: true,
              onChanged: (val) {
                setState(() {
                  selectedStatus = val.serviceName!;
                  serviceStatusId=val.serviceId;
                });
              },
            ),
          ),
          CustomMediumButton(
            isValidate: checkValidate(),
            buttonText: AppGeneralTrans.nextButtomTxt,
            onTap: () {
              if (checkValidate()) {

              setState(() {
                paymentFirstScreenModel=PaymentFirstScreenModel(
                    serviceId: serviceId,
                    serviceStatusId: serviceStatusId
                );
              });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentSecondFormScreen(),
                      settings: RouteSettings(
                          arguments: FirstScreenArgs(
                              isSignutre: isSigniture,
                            serviceId:serviceId ,
                            serviceStatusId:serviceStatusId,

                          ))),
                );

              } else {
                showToastWidget(
                     CustomToastWidget(
                      toastContent: AppGeneralTrans.dataRequirementValidationTxt,
                      toastStatus: ToastStatus.error,
                    ),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 4),
                    animationDuration: const Duration(seconds: 1),
                    animationCurve: Curves.decelerate);
              }
            },
          )
        ],
      ),
    );
  }
}
