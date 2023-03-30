
import 'package:hive/hive.dart';
part 'payment_service_status_model.g.dart';

@HiveType(typeId: 0)
class PaymentServiceStatusModel{
  @HiveField(0)
  final int?serviceId;
  @HiveField(1)
  final String?serviceName;

  PaymentServiceStatusModel({this.serviceId,this.serviceName});

  factory PaymentServiceStatusModel.fromJson(Map<String,dynamic>json){
    return PaymentServiceStatusModel(
        serviceId:json['id'],
        serviceName:json['name']
    );
  }

}