// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchesModelAdapter extends TypeAdapter<BranchesModel> {
  @override
  final int typeId = 12;

  @override
  BranchesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchesModel(
      name: fields[0] as String?,
      address: fields[1] as String?,
      map: fields[2] as String?,
      longitude: fields[3] as String?,
      latitude: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BranchesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.map)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.latitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
