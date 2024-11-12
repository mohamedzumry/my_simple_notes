import 'package:my_simple_notes/database/database_helper.dart';
import 'package:my_simple_notes/features/home/domain/entities/notes_category_with_note_count_model.dart';
import 'package:my_simple_notes/features/notes/data/models/note_data_model.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_repository.dart';

class SqlNotesRepository extends NotesRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<List<Note>> getNotes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (index) {
      return NoteDataModel.fromMap(maps[index]).toDomain();
    });
  }

  @override
  Future<List<Note>> getNotesByCategoryId(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'category_id = ?',
      whereArgs: [id],
    );

    return List.generate(maps.length, (index) {
      return NoteDataModel.fromMap(maps[index]).toDomain();
    });
  }

  @override
  Future<String> getNoteCategoryNameById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'notes_categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first['name'] as String;
    }
    return '';
  }

  @override
  Future<Note?> getNoteById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      NoteDataModel noteDataModel = NoteDataModel.fromMap(maps.first);
      return noteDataModel.toDomain();
    }
    return null;
  }

  @override
  Future<void> insertNote(Note note) async {
    final noteDataModel = NoteDataModel.fromDomain(note);
    final db = await _databaseHelper.database;
    await db.insert('notes', noteDataModel.toMap());
  }

  @override
  Future<void> updateNote(Note note) async {
    final noteDataModel = NoteDataModel.fromDomain(note);
    final db = await _databaseHelper.database;
    await db.update(
      'notes',
      noteDataModel.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NotesCategoryWithNoteCountModel>>
      getNotesCategoriesWithNoteCount() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT notes_categories.id, notes_categories.name, COUNT(notes.id) AS note_count
      FROM notes_categories
      LEFT JOIN notes ON notes.category_id = notes_categories.id
      GROUP BY notes_categories.id, notes_categories.name;
    ''');

    // Convert each result into a CategoryWithNoteCount object
    return List.generate(maps.length, (index) {
      return NotesCategoryWithNoteCountModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        noteCount: maps[index]['note_count'],
      );
    });
  }
}
