// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colors_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorsEntityAdapter extends TypeAdapter<ColorsEntity> {
  @override
  final int typeId = 7;

  @override
  ColorsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorsEntity(
      id: fields[0] as int?,
      key: fields[1] as String?,
      val: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ColorsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.val);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
