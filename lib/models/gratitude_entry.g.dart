

part of 'gratitude_entry.dart';





class GratitudeEntryAdapter extends TypeAdapter<GratitudeEntry> {
  @override
  final int typeId = 0;

  @override
  GratitudeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GratitudeEntry(
      text: fields[1] as String,
      timestamp: fields[2] as DateTime,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, GratitudeEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GratitudeEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
