// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icons_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IconsEntityAdapter extends TypeAdapter<IconsEntity> {
  @override
  final int typeId = 6;

  @override
  IconsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IconsEntity(
      imageKey: fields[0] as String?,
      imageUrl: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IconsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageKey)
      ..writeByte(1)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
