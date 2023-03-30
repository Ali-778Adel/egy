// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_cities_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentCitiesModelAdapter extends TypeAdapter<PaymentCitiesModel> {
  @override
  final int typeId = 2;

  @override
  PaymentCitiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentCitiesModel(
      cityId: fields[0] as int?,
      cityName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentCitiesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cityId)
      ..writeByte(1)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentCitiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
