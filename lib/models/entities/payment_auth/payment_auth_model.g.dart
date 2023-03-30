// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentAuthModelAdapter extends TypeAdapter<PaymentAuthModel> {
  @override
  final int typeId = 11;

  @override
  PaymentAuthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentAuthModel(
      expiration: fields[1] as String?,
      token: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentAuthModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expiration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAuthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
