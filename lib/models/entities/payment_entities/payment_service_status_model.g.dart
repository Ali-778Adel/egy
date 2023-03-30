// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentServiceStatusModelAdapter
    extends TypeAdapter<PaymentServiceStatusModel> {
  @override
  final int typeId = 0;

  @override
  PaymentServiceStatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentServiceStatusModel(
      serviceId: fields[0] as int?,
      serviceName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentServiceStatusModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.serviceId)
      ..writeByte(1)
      ..write(obj.serviceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentServiceStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
