import 'package:hive/hive.dart';
part 'locale_entity.g.dart';
@HiveType(typeId: 19)
class LocalEntity{
  @HiveField(0)
  final String ?val;

  LocalEntity({
    this.val
});

  factory LocalEntity.fromJson({required Map<String,dynamic>json}){
    return LocalEntity(val: json['val']);
  }
}