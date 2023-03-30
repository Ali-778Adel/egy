import 'package:hive/hive.dart';
part'icons_entity.g.dart';
@HiveType(typeId: 6)
class IconsEntity {
  @HiveField(0)
  final String?imageKey ;
  @HiveField(1)
  final String? imageUrl;

  IconsEntity({this.imageKey, this.imageUrl, });

  factory IconsEntity.fromJson({required Map<String,dynamic>json}){
    return IconsEntity(
        imageKey: json['imageKey'],
        imageUrl: json['imageUrl'],

    );
  }
}
