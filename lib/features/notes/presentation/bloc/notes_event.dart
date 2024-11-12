part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNoteCategoriesEvent extends NotesEvent {
  const LoadNoteCategoriesEvent();
  @override
  List<Object> get props => [];
}

class NaviagteToNotesListPageEvent extends NotesEvent {
  final int categoryId;
  const NaviagteToNotesListPageEvent(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}

class EditNoteEvent extends NotesEvent {
  final Note note;
  const EditNoteEvent(this.note);
  @override
  List<Object> get props => [note];
}

// Notes CRUD Events

class AddNoteEvent extends NotesEvent {
  final Note note;
  const AddNoteEvent(this.note);
  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;
  const UpdateNoteEvent(this.note);
  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final int id;
  const DeleteNoteEvent(this.id);
  @override
  List<Object> get props => [id];
}

// Notes Category CRUD Events

class AddNoteCategoryEvent extends NotesEvent {
  final NotesCategory noteCategory;
  const AddNoteCategoryEvent(this.noteCategory);
  @override
  List<Object> get props => [noteCategory];
}

class UpdateNoteCategoryEvent extends NotesEvent {
  final NotesCategory noteCategory;
  const UpdateNoteCategoryEvent(this.noteCategory);
  @override
  List<Object> get props => [noteCategory];
}

class DeleteNoteCategoryEvent extends NotesEvent {
  final int id;
  const DeleteNoteCategoryEvent(this.id);
  @override
  List<Object> get props => [id];
}
