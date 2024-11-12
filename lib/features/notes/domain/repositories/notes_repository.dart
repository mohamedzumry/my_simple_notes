import 'package:my_simple_notes/features/home/domain/entities/notes_category_with_note_count_model.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<List<Note>> getNotesByCategoryId(int id);
  Future<String> getNoteCategoryNameById(int id);
  Future<Note?> getNoteById(int id);
  Future<void> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(int id);
  Future<List<NotesCategoryWithNoteCountModel>>
      getNotesCategoriesWithNoteCount();
}
