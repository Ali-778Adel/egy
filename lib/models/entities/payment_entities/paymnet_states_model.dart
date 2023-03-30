import 'package:hive/hive.dart';
part 'paymnet_states_model.g.dart';

@HiveType(typeId: 3)
class PaymentStatesModel{
  @HiveField(0)
  final int?stateId;
  @HiveField(1)
  final String?stateName;

  PaymentStatesModel({
    this.stateId,this.stateName
  });

  factory PaymentStatesModel.fromJson(Map<String,dynamic>json){
    return PaymentStatesModel(
        stateId: json['id'],
        stateName: json['name']
    );
  }
}


