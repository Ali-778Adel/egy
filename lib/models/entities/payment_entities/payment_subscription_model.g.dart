// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_subscription_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentSubscriptionModelAdapter
    extends TypeAdapter<PaymentSubscriptionModel> {
  @override
  final int typeId = 4;

  @override
  PaymentSubscriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentSubscriptionModel(
      id: fields[0] as int?,
      periodName: fields[1] as String?,
      subPeriodCost: fields[2] as int?,
      isDiscount: fields[3] as bool?,
      discountCost: fields[4] as dynamic,
      discountPercent: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentSubscriptionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.periodName)
      ..writeByte(2)
      ..write(obj.subPeriodCost)
      ..writeByte(3)
      ..write(obj.isDiscount)
      ..writeByte(4)
      ..write(obj.discountCost)
      ..writeByte(5)
      ..write(obj.discountPercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentSubscriptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
