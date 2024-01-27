// notes_list.dart

import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'add_note_screen.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'drawer_screen.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  late Box<Note> notesBox;
  late List<Note> notes;
  String selectedDrawerItem = ''; // keeps track of the selected drawer option

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
      drawer: DrawerScreen(
        onDrawerItemPressed: _handleDrawerItemPressed,
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton (
                  icon: const Icon(Icons.delete_sharp),
                  onPressed: () => _confirmDelete(context, notes[index]),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_sharp),
                  onPressed: () => _editNote(context, notes[index]),
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

  void _editNote(BuildContext context, Note note) async {
    Note? editedNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen(editingNote: note)),
    );

    if (editedNote != null) {
      setState(() {
        notes[notes.indexOf(note)] = editedNote;
      });

      int noteIndex = notesBox.keys.toList().indexOf(note.key);
      notesBox.putAt(noteIndex, editedNote);
    }
  }

  void _handleDrawerItemPressed(String selectedItem) {
    setState(() {
      selectedDrawerItem = selectedItem;
    });
  }

  void _confirmDelete(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteNote(note);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(Note note) {
    setState(() {
      notes.removeWhere((element) => element.key == note.key);
      notesBox.delete(note.key);
    });
  }



  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy\nhh:mm a').format(dateTime);
  }
}
