// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlacesAdapter extends TypeAdapter<Locations> {
  @override
  final int typeId = 2;

  @override
  Locations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Locations(
      id: fields[0] as int?,
      tenantId: fields[1] as String?,
      name: fields[2] as String?,
      companyCode: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      isTerritory: fields[6] as bool?,
      status: fields[7] as bool?,
      type: fields[8] as int?,
      parent: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Locations obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.companyCode)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.isTerritory)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.parent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
