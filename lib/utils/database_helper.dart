import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/models/note.dart';

class DatabaseHelper {
  static final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const collection = 'notes';

  final FirebaseFirestore _firestore;

  DatabaseHelper._privateConstructor() : _firestore = FirebaseFirestore.instance {
    initializeFlutterFire();
  }

  Future<void> initializeFlutterFire() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "[YOUR_API_KEY]",
          projectId: "[YOUR_PROJECT_ID]",
          messagingSenderId: "[YOUR_MESSAGING_SENDER_ID]",
          appId: "[YOUR_APP_ID]",
        ),
      );
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }




  Future<Note?> add(Note note) async {

    final noteDoc = notesCollection.doc(); // create a new document reference
    final noteWithId = note.copyWith(id: noteDoc.id); // set the id field
    await noteDoc.set(noteWithId.toJson()); // save to the database




    print("Add method called");
    try {

      print("Note added successfully");

    } catch (e) {
      print("Error in adding note: $e");
      throw e;
    }
  }

  Future<void> update(Note note) async {

    final noteDoc = notesCollection.doc(note.id); // get the docume
    await noteDoc.update(note.toJson()); // update the document



    print("Update method called");
    try {
      if (note.id == null || note.id!.isEmpty) {
        throw Exception("Note id cannot be null or empty");
      }
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note.id)
          .update(note.toMap());
      print("Note updated successfully");
    } catch (e) {
      print("Error in updating note: $e");
      throw e;
    }
  }

  Future<void> delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(id).delete();
      print("Note deleted successfully");
    } catch (e) {
      print("Error in deleting note: $e");
      throw e;
    }
  }

  Future<Note?> getNoteById(String id) async {
    final docSnap = await _firestore.collection(collection).doc(id).get();

    if (!docSnap.exists) {
      return null;
    }

    return Note.fromMap(docSnap.data()!);
  }

  Future<List<Note>> getNotes() async {
    final snapshot = await _firestore.collection(collection).get();
    return snapshot.docs.map((doc) => Note.fromMap(doc.data()).copyWith(id: doc.id)).toList();
  }
  Future<Note?> fetchNote(String noteId) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection(collection).doc(noteId).get();
      if (!snapshot.exists) {
        return null;
      }
      final note = Note.fromMap(snapshot.data()!..putIfAbsent('id', () => noteId));
      return note;
    } catch (e) {
// handle the exception
      print(e);
      return null;
    }
  }
  Future<void> updateNote(Note note) async {
    try {
      if (note.id == null || note.id!.isEmpty) {
        throw Exception("Note id cannot be null or empty");
      }
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(note.id)
          .update(note.toJson());
      print("Note updated successfully");
    } catch (e) {
      print("Error in updating note: $e");
      throw e; // Re-throw the error to handle it in the calling code
    }
  }

}