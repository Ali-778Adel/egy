enum PaymentProcessStatus{ success,loading,error,completed}


abstract class FawryStates{}


class FawryInitState extends FawryStates{}

class FawryCallBackState extends FawryStates {
  final PaymentProcessStatus?paymentProcessStatus;
  final String?message;
  final Map<String,dynamic>?response;
  FawryCallBackState({required this.paymentProcessStatus,this.message,this.response});

}

class FawryInitiateStates extends FawryStates{}