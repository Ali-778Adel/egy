class ListApi {
  ListApi._();

  /// payment forms endpoints
  static const String serviceTypes = "Services";
  static const String serviceStatus = "ServicesStatus";
  static const String states = "States";
  static const String cities = "Cities";
  static const String subscriptions="Subscription";
  static const String userCheckLogin="EgyptTrustUsers/clientlogin";
  static const String followOrders="FollowOrder";
  static const String updateUserData="EgyptTrustUsers/updatefiles";
  static const String sendPaymentResponse="EgyptTrustUsers/PayResponse";





  /// home endpoints
  static const String translators='appTranslator';
  static const String translatorsUpdates='appTranslator/updatedText/7';

  /// theme endpoints
  static const String appIconsEndpoint='AppIcons';
  static const String appColorsEndpoint='AppColors';
  static const String appSliderImages='AppSlider';
  static const String appUpdates='appTranslator/checkUpdates';

///  paymentTranslators
   static const String viewTranslators="appTranslator/";
   static const String viewTransUpdates='appTranslator/updatedText/';


   ///auth endpoints

  static const String login="api/userauth/login";

  /// branches end point

  static const String allBranches='Branches/GetBranches/';

}
