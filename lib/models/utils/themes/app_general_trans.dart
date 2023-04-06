import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';

import '../../../di/dependency_injection.dart';

class AppGeneralTrans {
  AppGeneralTrans(_);

  static String getGeneralTransByKey(String key) {
    String appLocal = sl<ThemeBloc>().appLocal;
    try {
      if (appLocal == 'ar-SA') {
        return sl<ThemeBloc>()
            .appGeneralTrans
            .where((element) => element.key == key)
            .first
            .val!;
      } else {
        return sl<ThemeBloc>()
            .appGeneralTrans
            .where((element) => element.key == key)
            .first
            .valEn!;
      }
    } catch (e) {
      return '';
    }
  }

  static String dataRequirementValidationTxt =
      getGeneralTransByKey('dataRequirementValidationTxt');
  static String statesValidationTxt =
      getGeneralTransByKey('statesValidationTxt');
  static String cityValidationTxt = getGeneralTransByKey('cityValidationTxt');
  static String mobileValidationTxt =
      getGeneralTransByKey('mobileValidationTxt');
  static String emailValidationTxt = getGeneralTransByKey('emailValidationTxt');
  static String addressValidationTxt =
      getGeneralTransByKey('addressValidationTxt');
  static String nationalIdValidationTxt =
      getGeneralTransByKey('nationalIdValidationTxt');
  static String docStartDateEmptyValidationTxt =
      getGeneralTransByKey('docStartDateEmptyValidationTxt');
  static String docStartDateFormatValidationTxt =
      getGeneralTransByKey('docStartDateFormatValidationTxt');
  static String docStartDateTimeExceedValidationTxt =
      getGeneralTransByKey('docStartDateTimeExceedValidationTxt');
  static String docEndDateValidationTxt =
      getGeneralTransByKey('docEndDateValidationTxt');
  static String companyNameValidationTxt =
      getGeneralTransByKey('companyNameValidationTxt');
  static String subscriptionPeriodValidationTxt =
      getGeneralTransByKey('subscriptionPeriodValidationTxt');
  static String subscriptionCountValidationTxt =
      getGeneralTransByKey('subscriptionCountValidationTxt');
  static String commissionerNameValidationTxt =
      getGeneralTransByKey('commissionerNameValidationTxt');
  static String commissionerMobileValidationTxt =
      getGeneralTransByKey('commissionerMobileValidationTxt');
  static String commissionerNationalIdValidationTxt =
      getGeneralTransByKey('commissionerNationalIdValidationTxt');
  static String rulesAgreementValidationTxt =
      getGeneralTransByKey('rulesAgreementValidationTxt');
  static String internetExceptionTxt =
      getGeneralTransByKey('internetExceptionTxt');
  static String serverExceptionTxt = getGeneralTransByKey('serverExceptionTxt');
  static String unKnownExceptionTxt =
      getGeneralTransByKey('unKnownExceptionTxt');
  static String nextButtomTxt = getGeneralTransByKey('nextButtomTxt');
  static String perviousButtomTxt = getGeneralTransByKey('perviousButtomTxt');
  static String personNameTxt = getGeneralTransByKey('personNameTxt');
  static String enterTxt = getGeneralTransByKey('enterTxt');
  static String chooseStateFirst = getGeneralTransByKey('chooseStateFirst');
  static String tryAgainTxt = getGeneralTransByKey('tryAgainTxt');
  static String nationalIdTitleTxt = getGeneralTransByKey('nationalIdTitleTxt');
  static String totalTxt = getGeneralTransByKey('totalTxt');
  static String orderStatusTxt = getGeneralTransByKey('orderStatusTxt');
  static String completePaymentTxt = getGeneralTransByKey('completePaymentTxt');
  static String editFilesTxt = getGeneralTransByKey('editFilesTxt');
  static String sendDataTxt = getGeneralTransByKey('sendDataTxt');
  static String myOrdersTxt = getGeneralTransByKey('myOrdersTxt');
  static String buySealTxt = getGeneralTransByKey('buySealTxt');
  static String followOrderTxt = getGeneralTransByKey('followOrderTxt');
  static String refNumTxt = getGeneralTransByKey('refNumTxt');
  static String serviceTypeTxt = getGeneralTransByKey('serviceTypeTxt');
  static String serviceStatusTxt = getGeneralTransByKey('serviceStatusTxt');
  static String sealTxt = getGeneralTransByKey('sealTxt');
  static String signatureTxt = getGeneralTransByKey('signatureTxt');
  static String newTxt = getGeneralTransByKey('newTxt');
  static String reNewTxt = getGeneralTransByKey('reNewTxt');
  static String oredreNumberTxt = getGeneralTransByKey('oredreNumberTxt');
  static String uploadFilesErrorTxt =
      getGeneralTransByKey('uploadFilesErrorTxt');
  static String waitFawryConfirmationTxt =
      getGeneralTransByKey('waitFawryConfirmationTxt');
  static String notPaidYetTxt = getGeneralTransByKey('notPaidYetTxt');
  static String refNumberValidationTxt =
      getGeneralTransByKey('refNumberValidationTxt');
  static String actviateToken = getGeneralTransByKey('actviateToken');
  static String welcomeTxt = getGeneralTransByKey('welcomeTxt');
  static String pinTxt = getGeneralTransByKey('pinTxt');
  static String liecienceTxt = getGeneralTransByKey('liecienceTxt');
  static String secretKeyTxtTxt = getGeneralTransByKey('secretKeyTxtTxt');
  static String editTxt = getGeneralTransByKey('editTxt');
  static String secretKeyTxt = getGeneralTransByKey('secretKeyTxt');
  static String loginTxt = getGeneralTransByKey('loginTxt');
  static String langValidationTxt = getGeneralTransByKey('langValidationTxt');
  static String secretValidationTxt = getGeneralTransByKey('secretValidationTxt');
  static String saveTxt = getGeneralTransByKey('saveTxt');
  static String qrTxt = getGeneralTransByKey('qrTxt');
  static String qrEditiTxt = getGeneralTransByKey('qrEditiTxt');
  static String pinValidationTxt = getGeneralTransByKey('pinValidationTxt');
  static String sdCofigTxt = getGeneralTransByKey('sdCofigTxt');
  static String cancelTxt = getGeneralTransByKey('cancelTxt');
  static String natioanalIdTxt1 = getGeneralTransByKey('natioanalIdTxt1');
  static String issuanceSealTxt = getGeneralTransByKey('issuanceSealTxt');
  static String dataEditedTxt = getGeneralTransByKey('dataEditedTxt');
  static String companyTxt = getGeneralTransByKey('companyTxt');
  static String serialNumTxt = getGeneralTransByKey('serialNumTxt');
  static String certStartDateTxt = getGeneralTransByKey('certStartDateTxt');
  static String certEndDateTxt = getGeneralTransByKey('certEndDateTxt');
  static String showSignatureTxt = getGeneralTransByKey('showSignatureTxt');
  static String waitTxt = getGeneralTransByKey('waitTxt');
  static String egyTrustTxt = getGeneralTransByKey('egyTrustTxt');
  static String client = getGeneralTransByKey('client');
  static String natiionalIdTxt = getGeneralTransByKey('natiionalIdTxt');
  static String VategTxt = getGeneralTransByKey('VategTxt');
  static String emailTxt = getGeneralTransByKey('emailTxt');





}
