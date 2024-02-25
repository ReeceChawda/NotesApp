// add_note_screen.dart

import 'package:flutter/material.dart';
import '../models/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? editingNote;

  const AddNoteScreen({Key? key, this.editingNote}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.editingNote != null) {
      _titleController.text = widget.editingNote!.title;
      _contentController.text = widget.editingNote!.content;
    }
  }

// Make so back button in appbar saves the note as well
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextField(
            controller: _titleController,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter Title',
              hintStyle: TextStyle(
                color: Color.fromARGB(100, 255, 255, 255),
              ),
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 109, 123, 100),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter Note',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
            context,
            Note(
              title: _titleController.text,
              content: _contentController.text,
              dateTime: DateTime.now(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color.fromARGB(255, 87, 98, 80),
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
    );
  }
}
