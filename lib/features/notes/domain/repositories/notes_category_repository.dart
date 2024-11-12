import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';

abstract class NotesCategoryRepository {
  Future<List<NotesCategory>> getNoteCategories();

  Future<void> insertNoteCategory(NotesCategory notesCategory);

  Future<void> updateNoteCategory(NotesCategory notesCategory);

  Future<void> deleteNoteCategory(int id);
}
