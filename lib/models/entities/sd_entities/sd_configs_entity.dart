
import 'package:hive/hive.dart';
part 'sd_configs_entity.g.dart';
@HiveType(typeId: 21)
class SdConfigsEntity {
  @HiveField(0)
final String?pinCode;
  @HiveField(1)
final String?signatureCode;
  @HiveField(2)
final String?secretKey;
SdConfigsEntity({this.pinCode,this.signatureCode,this.secretKey});
}