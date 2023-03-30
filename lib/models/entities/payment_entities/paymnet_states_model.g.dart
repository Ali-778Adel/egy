// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymnet_states_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentStatesModelAdapter extends TypeAdapter<PaymentStatesModel> {
  @override
  final int typeId = 3;

  @override
  PaymentStatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentStatesModel(
      stateId: fields[0] as int?,
      stateName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentStatesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stateId)
      ..writeByte(1)
      ..write(obj.stateName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentStatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
