import 'package:hive/hive.dart';
part 'payment_auth_model.g.dart';
@HiveType(typeId: 11)
class PaymentAuthModel{
  @HiveField(0)
  final String?token;
  @HiveField(1)
  final String?expiration;

  PaymentAuthModel({this.expiration,this.token});
  factory PaymentAuthModel.fromJson({required Map<String,dynamic>json}){
    return PaymentAuthModel(token: json['token'],expiration:json['expiration']);
  }
}