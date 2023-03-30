// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_forms_resualt_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentFormsResultModelAdapter
    extends TypeAdapter<PaymentFormsResultModel> {
  @override
  final int typeId = 10;

  @override
  PaymentFormsResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentFormsResultModel(
      result: fields[0] as String?,
      orderNumber: fields[1] as String?,
      password: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentFormsResultModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.result)
      ..writeByte(1)
      ..write(obj.orderNumber)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentFormsResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
