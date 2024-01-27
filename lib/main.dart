// main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Pages/notes_list.dart';
import 'models/note_model.dart';

//hive database
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // main body
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notes App',
      home: NotesList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
