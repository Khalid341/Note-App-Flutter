import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Note {
  final String? id;
  final String title;
  final String description;
  final DateTime date;
  bool completed;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.completed = false,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      completed: map['completed'],
      date: DateTime.now()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'date': date,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? completed,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }

  void setCompleted(bool completed) {
    this.completed = completed;
  }

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return Note.fromMap(data);
  }

  Map<String, dynamic> toDocument() {
    return toMap()..remove('id');
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? Uuid().v4(),
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'completed': completed,
    };
  }

}