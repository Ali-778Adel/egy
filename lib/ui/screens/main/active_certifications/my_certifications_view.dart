import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/action/certification_actions_cubit_state.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit.dart';
import 'package:fl_egypt_trust/models/bloc/certification/certification_cubit_state.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/themes/colors.dart';
import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:fl_egypt_trust/ui/screens/main/active_certifications/row_certification.dart';
import 'package:fl_egypt_trust/ui/screens/main/home/subs/certifications/screen_certification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_loading.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_message_notification.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/bottom_revoke_certification_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ActiveCertificationsView extends StatefulWidget {
  const ActiveCertificationsView({Key? key}) : super(key: key);

  @override
  State<ActiveCertificationsView> createState() =>
      _ActiveCertificationsViewState();
}

class _ActiveCertificationsViewState extends State<ActiveCertificationsView> {
  final _pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getActiveCertifications();

  }

  _getActiveCertifications(){

    navigatorKey.currentContext?.read<CertificationCubit>().getActiveCertifications();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CertificationCubit, CertificationCubitState>(
        builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: state.isUserCertificationsLoading == true
                      ? const CircularProgressIndicator()
                      : _buildView(state),
                ),
              ),
            ),

            Visibility(
              visible: state.isUserCertificationsLoading == false
                  && state.userCertificationsErrorMessage == null
              && (state.userCertifications?.length?? 0) > 0
              ,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: state.userCertifications?.length ?? 0,
                    effect: ScrollingDotsEffect(
                      dotColor: UiConstants.colorHint.withOpacity(0.6),
                      activeDotColor: UiConstants.colorPrimary,

                      dotWidth: 5,
                      dotHeight: 5,
                      spacing: 5,
                    ), // your preferred effect
                    onDotClicked: (index) {}),
              ),
            ),
            Visibility(
              visible: state.isUserCertificationsLoading == false
                  && state.userCertificationsErrorMessage == null
          && (state.userCertifications?.length?? 0) > 0,
              child: Text(
                appLocalization.activeCertificationsCount.replaceAll('@{arg1}', state.userCertifications?.length.toString() ?? '0'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: UiConstants.colorTitle),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _buildView(CertificationCubitState state) {
    if(state.userCertificationsErrorMessage == null && (state.userCertifications?.length ?? 0) > 0) {
      return PageView(
      controller: _pageController,
      children: state.userCertifications?.map((e) => RowCertification(
        certification: e ,
        onRequestPinTap: (){
          _requestPin(e.certSerial ?? '');
        },
        onRevokeTap: (){
          _revokeCertification(e.certSerial ?? '');
        },
      ))
          .toList() ?? [],
    );
    }


    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.userCertificationsErrorMessage ?? appLocalization.noUserCertifications ,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                color: UiConstants.colorTitle
            ),

          ),

          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenCertification()),
                );
              },
              child: Text(appLocalization.createCertification.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
              style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all<Size>(const Size(200, 45)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      Palette.mainGreen),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side:  BorderSide(
                              color: Palette.mainGreen)))),
            ),
          )
        ],
      ),
    );
  }

  _requestPin(String certificationSerial)async{
    BottomSheetLoading.show(context, label: appLocalization.requestingCertificationPin);
    await context.read<CertificationActionsCubit>().requestCertificationPin(certificationSerial: certificationSerial);
    Navigator.of(context).pop();
    _checkActionStates();
  }

  void _checkActionStates() async{
    var state = context.read<CertificationActionsCubit>().state;
    if(state.isActionLoading == null) return;
    state.isActionLoading = null;
    await BottomSheetMessageNotification.show(context, label: state.certificationPinModel?.password ?? state.actionFailMessage ?? '');

  }


  _revokeCertification(String certificationSerial)async{
    BottomSheetLoading.show(context, label: appLocalization.revokingCertification);
    await context.read<CertificationActionsCubit>().requestRevokeCertificationPin(certificationSerial: certificationSerial);
    Navigator.of(context).pop();
    _checkRevokeActionStates(certificationSerial);
  }



  void _checkRevokeActionStates(String certificationSerial) async{
    var state = context.read<CertificationActionsCubit>().state;
    if(state.isActionLoading == null) return;
    state.isActionLoading = null;
    if(state.actionFailMessage != null){
      BottomSheetMessageNotification.show(context, label: state.actionFailMessage ?? '');
      return;
    }
    MapEntry<bool , String>? result = await BottomSheetRevokeCertificationOtp.show(context, certificationSerial :certificationSerial ,title: state.actionSuccessMessage ?? '');
    if(result != null && result.key == true){
      _getActiveCertifications();
      await BottomSheetMessageNotification.show(context, label: result.value);

    }

  }


}
