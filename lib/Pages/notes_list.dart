// notes_list.dart

import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'add_note_screen.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  _NotesListState createState() {
    return _NotesListState();
  }
}

class _NotesListState extends State<NotesList> {
  late Box<Note> notesBox;
  late List<Note> notes;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notes');
    notes = notesBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notes[index].content),
                Text(
                  _formatDateTime(notes[index].dateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNote() async {
    Note? newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );

    if (newNote != null) {
      setState(() {
        notes.add(newNote);
      });

      notesBox.add(newNote);
    }
  }
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy\nhh:mm a').format(dateTime);
  }
}
