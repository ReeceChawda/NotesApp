// notes_list.dart

import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'add_note_screen.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  _NotesListState createState() => _NotesListState();
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
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        title: const Text(
          'Notes App',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 109, 123, 100),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(8, 15, 8, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color.fromARGB(255, 109, 123, 100),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  notes[index].title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      notes[index].content,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      _formatDateTime(notes[index].dateTime),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(100, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
              // trailing: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //         icon: const Icon(Icons.delete_sharp),
              //         onPressed: () => _confirmDelete(context, notes[index]),
              //         color: Colors.white,
              //       ),
              //     IconButton(
              //       icon: const Icon(Icons.edit_sharp),
              //       onPressed: () => _editNote(context, notes[index]),
              //       color: Colors.white,
              //     ),
              //   ],
              // ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color.fromARGB(255, 109, 123, 100),
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
