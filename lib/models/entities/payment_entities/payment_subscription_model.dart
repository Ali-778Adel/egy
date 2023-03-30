
import 'package:hive/hive.dart';
part 'payment_subscription_model.g.dart';
@HiveType(typeId: 4)
class PaymentSubscriptionModel{
  @HiveField(0)
  final int?id;
  @HiveField(1)
  final String?periodName;
  @HiveField(2)
  final int?subPeriodCost;
  @HiveField(3)
  final bool?isDiscount;
  @HiveField(4)
  final double?discountCost;
  @HiveField(5)
  final int?discountPercent;

  PaymentSubscriptionModel({
    this.id,
    this.periodName,
    this.subPeriodCost,
    this.isDiscount,
    this.discountCost,
    this.discountPercent
});

 factory PaymentSubscriptionModel.fromJson({required Map<String,dynamic>json}){
   return PaymentSubscriptionModel(
       id: json['id'],
       periodName:json['periodName'],
       subPeriodCost: json['periodCost'],
       isDiscount: json['isDiscount'],
      discountCost: json['discountCost'],
     discountPercent: json['discountPercent']
   );
  }

}