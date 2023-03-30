
import 'package:hive/hive.dart';

part 'payment_cities_model.g.dart';

@HiveType(typeId: 2)
class PaymentCitiesModel{
  @HiveField(0)
  final int?cityId;
  @HiveField(1)
  final String?cityName;

  PaymentCitiesModel({
    this.cityId,this.cityName
});

  factory PaymentCitiesModel.fromJson(Map<String,dynamic>json){
    return PaymentCitiesModel(
      cityId: json['id'],
      cityName: json['name']
    );
  }
}