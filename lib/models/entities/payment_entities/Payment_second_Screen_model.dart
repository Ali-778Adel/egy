import 'package:fl_egypt_trust/models/entities/payment_entities/payment_cities_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/payment_subscription_model.dart';
import 'package:fl_egypt_trust/models/entities/payment_entities/paymnet_states_model.dart';

class PaymentSecondScreenArgsModel {
  final PaymentStatesModel? paymentStatesModel;
  final PaymentCitiesModel? paymentCitiesModel;
  final PaymentSubscriptionModel?paymentSubscriptionModel;
  final String? phoneNumber;
  final String? userName;
  final String? emailAddress;
  final String? address;
  final String? nationalId;
  final String? companyName;
  final String?taxNumber;
  final String? subscriptionPeriod;
  final String? docStartDate;
  final String? docEndDate;
  final String? signatureNumber;
  final String? facebookMessages;
  final String? whatsAppMessages;
  final String? authorizedName;
  final String? authorizedPhoneNumber;
  final String? authorizedNationalId;
  final bool? freeMissions;
  final bool? discountNotification;
  final bool? authorized;
  final int?serviceId;
  final int?serviceStatusId;
  final int?subscriptionId;
  final double?total;
  final String ?selectedServiceProvider;
  final String?authorizedSelectedServiceProvider;

  PaymentSecondScreenArgsModel(
      {
        this.subscriptionId,
        this.serviceId,
        this.serviceStatusId,
        this.paymentStatesModel,
        this.paymentCitiesModel,
        this.paymentSubscriptionModel,
        this.phoneNumber,
        this.userName,
        this.address,
        this.emailAddress,
        this.nationalId,
        this.companyName,
        this.taxNumber,
        this.subscriptionPeriod,
        this.docStartDate,
        this.docEndDate,
        this.signatureNumber,
        this.facebookMessages,
        this.whatsAppMessages,
        this.authorizedName,
        this.authorizedPhoneNumber,
        this.authorizedNationalId,
        this.authorized,
        this.discountNotification,
        this.freeMissions,
        this.total,
        this.selectedServiceProvider,
        this.authorizedSelectedServiceProvider,

      });
}
