import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';

class NotesCategoryDataModel {
  final int? id;
  final String name;

  NotesCategoryDataModel({
    this.id,
    required this.name,
  });

  // Convert NotesCategoryDataModel to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Convert a Map from database to NotesCategoryDataModel
  factory NotesCategoryDataModel.fromMap(Map<String, dynamic> map) {
    return NotesCategoryDataModel(
      id: map['id'],
      name: map['name'],
    );
  }

  // Convert to Domain Model
  NotesCategory toDomain() {
    return NotesCategory(
      id: id,
      name: name,
    );
  }

  // Create NotesCategoryDataModel from Domain Model
  factory NotesCategoryDataModel.fromDomain(NotesCategory category) {
    return NotesCategoryDataModel(
      id: category.id,
      name: category.name,
    );
  }
}
