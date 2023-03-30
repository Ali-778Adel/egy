import 'package:hive/hive.dart';
part 'payment_service_type_model.g.dart';

@HiveType(typeId: 1)
class PaymentServiceTypeModel{
  @HiveField(0)
  final int?serviceId;
  @HiveField(2)
  final String?serviceName;

  PaymentServiceTypeModel({this.serviceId,this.serviceName});

  factory PaymentServiceTypeModel.fromJson(Map<String,dynamic>json){
    return PaymentServiceTypeModel(
      serviceId:json['id'],
      serviceName:json['name']
    );
  }

}