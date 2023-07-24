import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/utils/database_helper.dart';

import '../homepage/homepage.dart';

class NoteCard extends StatefulWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            'notedetails',
            arguments: widget.note, // Pass the Note object as an argument
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _completed,
                    onChanged: (value) {
                      setState(() {
                        _completed = value!;
                        widget.note.setCompleted(value); // Update the note's completed status
                      });
                    },
                  ),
                  Text(
                    widget.note.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),

              SizedBox(height: 16.0),



              InkResponse(
                onTap: () async {
                  if (widget.note.id != null) {
                    await DatabaseHelper.instance.delete(widget.note.id.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Note deleted'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: Icon(Icons.delete),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteNote(int id) async {
    int noteId = widget.note.id as int;

    await DatabaseHelper.instance.delete(noteId as String);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Note deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}