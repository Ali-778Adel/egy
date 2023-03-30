// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentServiceTypeModelAdapter
    extends TypeAdapter<PaymentServiceTypeModel> {
  @override
  final int typeId = 1;

  @override
  PaymentServiceTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentServiceTypeModel(
      serviceId: fields[0] as int?,
      serviceName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentServiceTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.serviceId)
      ..writeByte(2)
      ..write(obj.serviceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentServiceTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
