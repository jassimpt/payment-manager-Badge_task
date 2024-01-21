// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitorsmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitorsModelAdapter extends TypeAdapter<VisitorsModel> {
  @override
  final int typeId = 2;

  @override
  VisitorsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisitorsModel(
      name: fields[0] as String,
      sponsorname: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VisitorsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sponsorname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitorsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
