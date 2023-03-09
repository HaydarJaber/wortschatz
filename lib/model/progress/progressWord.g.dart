// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progressWord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 0;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word()
      ..diff = fields[0] as String
      ..freq = fields[1] as String
      ..category = fields[2] as String
      ..word = fields[3] as String
      ..rOderF = fields[4] as String
      ..H1 = fields[5] as int
      ..H2 = fields[6] as int
      ..H3 = fields[7] as int
      ..H4 = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.diff)
      ..writeByte(1)
      ..write(obj.freq)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.word)
      ..writeByte(4)
      ..write(obj.rOderF)
      ..writeByte(5)
      ..write(obj.H1)
      ..writeByte(6)
      ..write(obj.H2)
      ..writeByte(7)
      ..write(obj.H3)
      ..writeByte(8)
      ..write(obj.H4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
