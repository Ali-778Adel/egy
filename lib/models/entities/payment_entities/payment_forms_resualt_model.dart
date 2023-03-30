
import 'package:hive/hive.dart';
part 'payment_forms_resualt_model.g.dart';


@HiveType(typeId: 10)
class PaymentFormsResultModel{
  @HiveField( 0)
  final String?result;
  @HiveField( 1)
  final String?orderNumber;
  @HiveField( 2)
  final String?password;

  final String?msg;

  PaymentFormsResultModel({this.result,this.orderNumber,this.password,this.msg});

 factory PaymentFormsResultModel.fromJson(Map<String,dynamic>json){
    return PaymentFormsResultModel(result: json['result'],orderNumber: json['orderNumber'],password:json['password'],msg:json['msg'] );
  }
}