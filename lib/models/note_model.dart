// note_model.dart

import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  bool isPriority;

  Note({
    required this.title,
    required this.content,
    required this.dateTime,
    this.isPriority = false,
  });
}
