import 'package:my_simple_notes/features/notes/domain/entities/note.dart';

class NoteDataModel {
  final int? id;
  final String title;
  final String content;
  final int categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NoteDataModel({
    this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  // Convert NoteDataModel to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category_id': categoryId,
    };
  }

  // Convert a Map from database to NoteDataModel
  factory NoteDataModel.fromMap(Map<String, dynamic> map) {
    return NoteDataModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      categoryId: map['category_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  // Convert to Domain Model
  Note toDomain() {
    return Note(
      id: id,
      title: title,
      content: content,
      categoryId: categoryId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Create NoteDataModel from Domain Model
  factory NoteDataModel.fromDomain(Note note) {
    return NoteDataModel(
      id: note.id,
      title: note.title,
      content: note.content,
      categoryId: note.categoryId,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
  }
}
