// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_translator_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PublicTranslatorEntityAdapter
    extends TypeAdapter<PublicTranslatorEntity> {
  @override
  final int typeId = 5;

  @override
  PublicTranslatorEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublicTranslatorEntity(
      id: fields[0] as int?,
      view: fields[1] as String?,
      key: fields[2] as String?,
      val: fields[3] as String?,
      valEn: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PublicTranslatorEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.view)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.val)
      ..writeByte(4)
      ..write(obj.valEn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicTranslatorEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
