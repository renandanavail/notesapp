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
  void updateNote(Note note) {
    // pre-fill text controller with existing note
    noteController.text = note.content;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Update Note"),
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
                  // save in db
                  notesDatabase.updateNote(note, noteController.text);

                  Navigator.pop(context);
                  noteController.clear();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // user wants to delete note
  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Note?"),
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
                  // save in db
                  notesDatabase.deleteNote(note);

                  Navigator.pop(context);
                  noteController.clear();
                },
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "NoteNest",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
      ),

      // Button
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),

      // Body -> Stream Builder
      body: StreamBuilder(
        // listen to this stream
        stream: notesDatabase.stream,

        // to build our UI..
        builder: (context, snapshot) {
          // loading..
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded!
          final notes = snapshot.data!;

          // list of notes UI
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              // get each note
              final note = notes[index];

              // list tile UI
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(note.content),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // update button
                          IconButton(
                            onPressed: () => updateNote(note),
                            icon: const Icon(Icons.edit),
                          ),
                          // delete button
                          IconButton(
                            onPressed: () => deleteNote(note),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
