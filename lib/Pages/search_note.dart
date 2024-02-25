// search_note.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';


class NoteSearch extends SearchDelegate<Note?> {
  final List<Note?> notes;
  final void Function(Note) onEditNote;
  final void Function(Note) onConfirmDelete;

  NoteSearch(this.notes, {required this.onEditNote, required this.onConfirmDelete});



  @override
  String get searchFieldLabel => 'Search Note';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 109, 123, 100),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(100, 255, 255, 255),
        ),
        border: InputBorder.none,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Color.fromARGB(200, 87, 98, 80),
        selectionHandleColor: Color.fromARGB(255, 87, 98, 80),
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy\nhh:mm a').format(dateTime);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 20,
        color: Colors.white,
      );

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return Container();
    }

    final searchResults = notes.where((note) =>
        note != null &&
        (note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase())));

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final note = searchResults.elementAt(index);
        if (note != null) {
          return GestureDetector(
            onTap: () => onEditNote(note),
            onLongPress: () => onConfirmDelete(note),
          child: Card(
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
                  note.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                      note.content,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      _formatDateTime(notes[index]!.dateTime),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(100, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        } else {
          return Container(); // or any other placeholder widget
        }
      },
    );
  }
}