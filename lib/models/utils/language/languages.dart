abstract class Languages {

  String get welcome;
  String get home;
  String get activeCertification;
  String get myActiveCertification;
  String get bookAppointment;
  String get createCertification;
  String get reservationInquiry;
  String get orderInquiry;
  String get login;
  String get activeCertificationsPreLoginMessage;
  String get requestPin;
  String get revoke;
  String get activeCertificationsCount;
  String get callus;
  String get callusHint;
  String get chat;
  String get chatHint;
  String get branches;
  String get branchesHint;
  String get settings;
  String get changeLanguage;
  String get changeLanguageHint;
  String get changePasswordHint;
  String get password;
  String get passwordHint;
  String get logout;
  String get name;
  String get mobileNumber;
  String get nationalId;
  String get selectCity;
  String get selectBranch;
  String get selectServiceType;
  String get pickupDate;
  String get selectVisitTime;
  String get reserve;
  String get orderNumber;
  String get selectCertificationType;
  String get submit;
  String get search;
  String get documentNameRequired;
  String get addAnotherDocument;
  String get saveReservation;
  String get cancelReservation;
  String get save;
  String get ourBranches;
  String get navigation;
  String get allCities;
  String get forgotPassword;
  String get donotHaveAccount;
  String get createAccount;
  String get enterMobileHint;
  String get next;
  String get enterOtpHint;
  String get donotGetOtp;
  String get resend;
  String get createPasswordHint;
  String get confirmPassword;
  String get register;
  String get registration;
  String get mobileVerification;
  String get createPassword;
  String get profile;
  String get newInEgyptTrust;
  String get newInEgyptTrustHint;
  String get activateTokenPin;
  String get contacts;
  String get whatsAppNotInstalledMessage;
  String get errorEnterCode;
  String get errorEnterEmail;
  String get errorEnterNationalId;
  String get errorEnterName;
  String get errorEnterCorrectNationalId;
  String get errorEnterMobile;
  String get errorEnterCorrectMobile;
  String get errorEnterPassword;
  String get errorEnterCurrentPassword;
  String get errorEnterNewPassword;
  String get errorEnterConfirmPassword;
  String get errorMismatchPassword;
  String get errorChooseCertificateType;
  String get errorUploadDocumentImage;
  String get errorEnterDocumentName;
  String get errorDocumentSize;
  String get errorSelectCity;
  String get errorSelectBranch;
  String get errorPickupDate;
  String get errorSelectService;
  String get errorSelectVisitTime;
  String get appName;
  String get cancel;
  String get camera;
  String get fileManager;
  String get pickTypeTitle;
  String get ok;
  String get pickMapTitle;
  String get easyLoginMessage;
  String get reservationInquiryMessage;
  String get orderInquiryMessage;
  String get editReservation;
  String get editCertification;
  String get changePassword;
  String get newPassword;
  String get errorEnterOtp;
  String get confirm;
  String get requestPinTitle;
  String get requestPinMessage;
  String get revokeTitle;
  String get revokeMessage;
  String get requestingCertificationPin;
  String get revokingCertification;
  String get resetPassword;
  String get revokeCertificationOtpMessage;
  String get noUserCertifications;
  String get unsavedChangesTitle;
  String get unsavedChangesMessage;
  String get logoutMessage;
  String get discard;
  String get view;
  String get gallery;
  String get permissionsDeniedTitle;
  String get permissionsDeniedMessage;
  String get back;
  String get revokeCertification;
  String get appUpdate;
  String get update;





}

enum EnumLanguage { english, arabic }

extension ExtensionEnumLanguage on EnumLanguage {
  String localeValue() {
    switch (this) {
      case EnumLanguage.arabic:
        return 'ar';
      default:
        return 'en';
    }
  }
}

enum EnumNetworkLangs{ arabic , english }

extension ExtensionEnumNetworkLangs on EnumNetworkLangs{
  String networkLocalValue(){
    switch(this){
      case EnumNetworkLangs.arabic:{
        return 'ar-SA';
      }
      default:{
        return 'en-US';
      }
    }
  }
}

