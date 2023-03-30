abstract class FawryEvents{}

enum FawryCallBackResponsStatus{error,completed,success}

class StartFawryCallBackResponseEvent extends FawryEvents{
  final FawryCallBackResponsStatus fawryCallBackResponsStatus;
  final String?message;
  final String?response;
  StartFawryCallBackResponseEvent({required this.fawryCallBackResponsStatus,this.message,this.response});
}

class InitiateFawryPaymentEvent extends FawryEvents{
  final double price;
  final String userRefNumber;
  final String merchantRefNumber;
  final String customerMail;
  final String customerMobile;

  InitiateFawryPaymentEvent({required this.price,required this.userRefNumber,required this.merchantRefNumber
  ,required this.customerMail,
    required this.customerMobile
  });
}


