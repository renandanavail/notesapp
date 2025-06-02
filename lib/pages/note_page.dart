import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/services/note_database.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // notes db
  final notesDatabase = NoteDatabase();

  // text controller
  final noteController = TextEditingController();

  // user wants to add new note
  void addNewNote() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("New Note"),
            content: TextField(controller: noteController),
            actions: [
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  noteController.clear();
                },
                child: const Text("Cancel"),
              ),

              // save button
              TextButton(
                onPressed: () {
                  // create a new note
                  final newNote = Note(content: noteController.text);
                  // save in db
                  notesDatabase.createNote(newNote);

                  Navigator.pop(context);
                  noteController.clear();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // user wants to update note

  // user wants to delete note

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(title: const Text("Notes")),

      // Button
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
