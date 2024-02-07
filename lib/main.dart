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
  const MyApp({Key? key}) : super(key: key);


  // main body
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Color.fromARGB(200, 87, 98, 80),
          selectionHandleColor: Color.fromARGB(255, 87, 98, 80),
        ),
      ),
      title: 'Notes',
      home: const NotesList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
