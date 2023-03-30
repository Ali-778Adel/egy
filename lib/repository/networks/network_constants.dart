class NetworkConstants {
  /// local development

  static const String baseUrl = 'https://etapp.egypttrust.com/api/Mobsys2/';
  static const String methodListBranches = 'ListBranches';
  static const String methodListServiceType = 'ListServiceTypes';
  static const String methodListCertificationsType = 'ListCertificateTypes';
  static const String methodListAvailableTimes = 'ListAvailableTimes';
  static const String methodReserveTicket = 'ReserveTicket';
  static const String methodReserveOrder = 'ReserveOrder';
  static const String methodLogin = 'UserLogin';
  static const String methodSystemOptions = 'SystemOptions';
  static const String methodRegister = 'RegisterUser';
  static const String methodForgot = 'UserForgot';
  static const String methodForgotConfirm = 'UserForgotConfirm';
  static const String methodUserChangePwd = 'UserChangePwd';
  static const String methodCheckToken = 'checktoken';
  static const String methodUserCertifications = 'ListUserCertificates';
  static const String methodRevokeCertification = 'RevokeCertificate';
  static const String methodRequestCertificationOtpPin = 'RequestOtpPin';
  static const String methodSendCertificationOtpRevoke = 'RequestOtpRevoke';
  static const String methodSendCertificationOtpPin = 'sendOtpPin';
  static const String methodInquiryReservation = 'MyReservation';
  static const String methodInquiryOrder = 'QueryOrder';
  static const String methodRequestActivateToken = 'RequestActivateToken';
  static const String methodActivateToken = 'ActivateToken';

  static const String keyId = 'id';

  static const Map<String, String> requestHeader = {
    'Accept': 'application/json',
    'Content-type': 'application/json'
  };

}
