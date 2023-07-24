import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/utils/database_helper.dart';

import '../details/note_details.dart';
import '../generated/app_localizations.dart';

class AddNotes extends StatefulWidget {
  final Note? note;

  const AddNotes({Key? key, this.note}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final DatabaseHelper _db;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _descriptionController =
        TextEditingController(text: widget.note?.description);
    _db = DatabaseHelper.instance;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final note = widget.note?.copyWith(
        title: title,
        description: description,
      ) ??
          Note(
            title: title,
            description: description,
            date: DateTime.now(),
          );

      if (widget.note != null) {
        if (widget.note!.id != null && widget.note!.id!.isNotEmpty) {
          await _db.update(note.copyWith(id: widget.note!.id));
        } else {
          print("Error in updating note: Note id cannot be null or empty");
        }
      } else {
        await _db.add(note);
      }

      // Navigate back to the HomePage
      Navigator.pop(context, true); // Pass true to indicate that the note was updated successfully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate('addNote') ?? "Default Text"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)
                      .translate('enterTitle') ??
                      "Default Text",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)
                      .translate('enterDescription') ??
                      "Default Text",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                maxLines: null,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _saveNote,
                  child: Text(
                    widget.note == null
                        ? AppLocalizations.of(context)
                        .translate('save') ??
                        'Default Text'
                        : AppLocalizations.of(context)
                        .translate('update') ??
                        'Default Text',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}