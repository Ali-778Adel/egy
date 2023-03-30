abstract class PaymentSecondFormEvents{}

class GetSecondFormStatesDataEvent extends PaymentSecondFormEvents {

}

class GetSecondFormCitiesDataEvent extends PaymentSecondFormEvents{
  final int stateId;
  GetSecondFormCitiesDataEvent({required this.stateId});
}
class RebuildEvent extends PaymentSecondFormEvents{
  final int stateId;
RebuildEvent({required this.stateId});
}

class GetSecondFormSubscriptionsDataEvent extends PaymentSecondFormEvents{
  final int?serviceId;
  GetSecondFormSubscriptionsDataEvent({required this.serviceId});
}