import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/note_card.dart';
import 'package:note_app/utils/database_helper.dart';

import '../create/add_notes.dart';
import '../generated/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Note>> _notesFuture;
  late final DatabaseHelper _db;

  @override
  void initState() {
    super.initState();
    _db = DatabaseHelper.instance;
    _fetchNotes();
  }

  void _fetchNotes() {
    setState(() {
      _notesFuture = _db.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('notes') ?? 'Default Text',
        ),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final notes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(note: note);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotes(note: null)),
          );
          if (result != null && result) {
            _fetchNotes();
          }
        },
        child: Icon(Icons.add),
      ),

    );
  }
}