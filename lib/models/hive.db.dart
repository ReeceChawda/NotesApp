// hive_db.dart

import 'package:hive/hive.dart';
import 'note_model.dart';

class HiveDB {
  static const String hive_box = 'notes';

  Future<void> addNote(Note note) async {
    var box = await Hive.openBox<Note>(hive_box);
    await box.add(note);
    await box.add(note);
  }

  Future<List<Note>> getNotes() async {
    var box = await Hive.openBox<Note>(hive_box);
    var notes = box.values.toList();
    await box.close();
    return notes;
  }
}
