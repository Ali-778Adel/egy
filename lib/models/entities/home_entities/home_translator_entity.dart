import 'package:hive/hive.dart';

part 'home_translator_entity.g.dart';

@HiveType(typeId: 5)
class PublicTranslatorEntity{
  @HiveField(0)
  final int?id;
  @HiveField(1)
  final String?view;
  @HiveField(2)
  final String?key;
  @HiveField(3)
  final String?val;
  @HiveField(4)
  final String?valEn;

  PublicTranslatorEntity({this.id,this.view,this.key,this.val,this.valEn});

  factory PublicTranslatorEntity.fromJson({required Map<String,dynamic>json}){
    return PublicTranslatorEntity(
      id:json['id'],
      view: json['view'],
      key:json['key'],
      val:json['val'],
      valEn: json['valEn']
    );
  }
}