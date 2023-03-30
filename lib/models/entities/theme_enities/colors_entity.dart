import 'package:hive/hive.dart';
part 'colors_entity.g.dart';

@HiveType(typeId: 7)
class ColorsEntity {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? key;
  @HiveField(2)
  final String? val;
  ColorsEntity({this.id, this.key, this.val});

  factory ColorsEntity.fromJson({required Map<String,dynamic>json}){
    return ColorsEntity(
        id: json['id'],
        key: json['key'],
        val: json['val']

    );
  }
}
