// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalEntityAdapter extends TypeAdapter<LocalEntity> {
  @override
  final int typeId = 19;

  @override
  LocalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalEntity(
      val: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.val);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
