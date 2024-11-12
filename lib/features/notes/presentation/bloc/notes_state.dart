part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

abstract class NotesActionState extends NotesState {
  const NotesActionState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class EditNotePageLoadedState extends NotesState {
  final Note note;
  const EditNotePageLoadedState({required this.note});

  @override
  List<Object> get props => [note];
}

// Notes List States
class NotesListLoadingState extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesListLoadedState extends NotesState {
  final List<Note> notesList;
  final NotesCategory notesCategory;

  const NotesListLoadedState(
      {required this.notesList, required this.notesCategory});

  @override
  List<Object> get props => [notesList, notesCategory];
}

class NotesListLoadingErrorState extends NotesState {
  final String message;

  const NotesListLoadingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// Notes CRUD States
class NotesCRUDLoadingState extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesCRUDSuccessState extends NotesActionState {
  const NotesCRUDSuccessState();
  @override
  List<Object> get props => [];
}

class NotesCRUDErrorState extends NotesActionState {
  final String message;
  const NotesCRUDErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// Notes Categories List
class NotesCategoriesListLoadingState extends NotesState {
  const NotesCategoriesListLoadingState();
  @override
  List<Object> get props => [];
}

class NotesCategoriesListLoadedState extends NotesState {
  final List<NotesCategory> notesCategoriesList;

  const NotesCategoriesListLoadedState({required this.notesCategoriesList});
  @override
  List<Object> get props => [notesCategoriesList];
}

class NotesCategoriesListLoadingErrorState extends NotesState {
  final String message;

  const NotesCategoriesListLoadingErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

// Notes Category CRUD States
class NotesCategoryCRUDLoadingState extends NotesState {
  const NotesCategoryCRUDLoadingState();
  @override
  List<Object> get props => [];
}

class NotesCategoryCRUDSuccessState extends NotesActionState {
  const NotesCategoryCRUDSuccessState();
  @override
  List<Object> get props => [];
}

class NotesCategoryCRUDErrorState extends NotesActionState {
  final String message;

  const NotesCategoryCRUDErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
