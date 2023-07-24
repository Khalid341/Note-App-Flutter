import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/utils/database_helper.dart';

import '../create/add_notes.dart';


class NoteDetails extends StatefulWidget {
  final Note note;

  const NoteDetails({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  Note? _note;

  @override
  void initState() {
    super.initState();
    _fetchNoteDetails();
  }

  void _fetchNoteDetails() async {
    final db = DatabaseHelper.instance;
    final noteId = widget.note.id;

    if (noteId == null || noteId.isEmpty) {
      print('Note id is null or empty');
      setState(() {
        _note = Note(
          id: "0",
          title: 'Error',
          description: 'Note ID is null or empty',
          date: DateTime.now(),
        );
      });
      return;
    }

    try {
      final note = await db.fetchNote(noteId);
      if (note == null) {
        print('Note not found');
        // handle the case when the note is not found in the database
      } else {
        print('Fetched note description: ${note.description}');
        setState(() {
          _note = note;
        });
      }
    } catch (e) {
      print('Failed to fetch note: $e');
      // handle the database error
    }
  }


  void _updateNote() async {
    if (_note?.id == null || _note!.id!.isEmpty) {
      print('Note id is null or empty');
      return;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotes(note: _note)),
    );
    if (result != null && result) {
      _fetchNoteDetails();
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_note == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_note!.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _updateNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_note!.description),
      ),
    );
  }
}
