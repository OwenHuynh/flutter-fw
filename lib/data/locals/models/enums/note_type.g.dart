// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final int typeId = 1;

  @override
  NoteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteType.NEW;
      case 1:
        return NoteType.INPROGRESS;
      case 2:
        return NoteType.DONE;
      default:
        return NoteType.NEW;
    }
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    switch (obj) {
      case NoteType.NEW:
        writer.writeByte(0);
        break;
      case NoteType.INPROGRESS:
        writer.writeByte(1);
        break;
      case NoteType.DONE:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
