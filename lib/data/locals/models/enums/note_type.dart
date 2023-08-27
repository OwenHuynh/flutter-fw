import 'package:hive/hive.dart';

part 'note_type.g.dart';

@HiveType(typeId: 1)
enum NoteType {
  @HiveField(0)
  NEW,
  @HiveField(1)
  INPROGRESS,
  @HiveField(2)
  DONE
}

const _noteTypeEnumMap = {
  NoteType.NEW: "NEW",
  NoteType.INPROGRESS: "INPROGRESS",
  NoteType.DONE: "DONE",
};

extension NoteTypeString on NoteType {
  String? asString() => _noteTypeEnumMap[this];
}
