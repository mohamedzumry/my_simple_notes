import 'package:my_simple_notes/database/database_helper.dart';
import 'package:my_simple_notes/features/notes/data/models/notes_category_data_model.dart';
import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_category_repository.dart';

class SqlNotesCategoryRepository extends NotesCategoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<void> deleteNoteCategory(int id) async {
    // Delete note category and all notes that belong to it
    final db = await _databaseHelper.database;
    await db.delete('notes_categories', where: 'id = ?', whereArgs: [id]);
    await db.delete('notes', where: 'category_id = ?', whereArgs: [id]);
  }

  @override
  Future<List<NotesCategory>> getNoteCategories() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes_categories');

    return List.generate(maps.length, (index) {
      return NotesCategoryDataModel.fromMap(maps[index]).toDomain();
    });
  }

  @override
  Future<void> insertNoteCategory(NotesCategory notesCategory) async {
    final notesCategoryDataModel =
        NotesCategoryDataModel.fromDomain(notesCategory);
    final db = await _databaseHelper.database;
    await db.insert('notes_categories', notesCategoryDataModel.toMap());
  }

  @override
  Future<void> updateNoteCategory(NotesCategory notesCategory) async {
    final notesCategoryDataModel =
        NotesCategoryDataModel.fromDomain(notesCategory);
    final db = await _databaseHelper.database;
    await db.update('notes_categories', notesCategoryDataModel.toMap(),
        where: 'id = ?', whereArgs: [notesCategory.id]);
  }
}
