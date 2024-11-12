import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_notes/features/notes/data/repositories/sql_notes_category_repository.dart';
import 'package:my_simple_notes/features/notes/data/repositories/sql_notes_repository.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';
import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_category_repository.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository = SqlNotesRepository();
  final NotesCategoryRepository _notesCategoryRepository =
      SqlNotesCategoryRepository();

  NotesBloc() : super(NotesInitial()) {
    on<NotesEvent>((event, emit) {});
    on<NaviagteToNotesListPageEvent>(naviagteToNotesListPageEvent);
    on<AddNoteEvent>(addNoteEvent);
    on<EditNoteEvent>(editNoteEvent);
    on<UpdateNoteEvent>(updateNoteEvent);
    on<DeleteNoteEvent>(deleteNoteEvent);
    on<AddNoteCategoryEvent>(addNoteCategoryEvent);
    on<UpdateNoteCategoryEvent>(updateNoteCategoryEvent);
    on<DeleteNoteCategoryEvent>(deleteNoteCategoryEvent);
  }

  FutureOr<void> naviagteToNotesListPageEvent(
      NaviagteToNotesListPageEvent event, Emitter<NotesState> emit) async {
    emit(NotesListLoadingState());
    try {
      final notesCategoryName =
          await _notesRepository.getNoteCategoryNameById(event.categoryId);
      final notes =
          await _notesRepository.getNotesByCategoryId(event.categoryId);

      final notesCatgeory =
          NotesCategory(name: notesCategoryName, id: event.categoryId);
      emit(
          NotesListLoadedState(notesList: notes, notesCategory: notesCatgeory));
    } catch (error) {
      emit(NotesListLoadingErrorState(message: error.toString()));
    }
  }

  FutureOr<void> addNoteEvent(
      AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.insertNote(event.note);
      emit(NotesCRUDSuccessState());
    } catch (error) {
      emit(NotesCRUDErrorState(message: error.toString()));
    }
  }

  FutureOr<void> editNoteEvent(EditNoteEvent event, Emitter<NotesState> emit) {
    emit(EditNotePageLoadedState(note: event.note));
  }

  FutureOr<void> updateNoteEvent(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.updateNote(event.note);
      emit(NotesCRUDSuccessState());
    } catch (error) {
      emit(NotesCRUDErrorState(message: error.toString()));
    }
  }

  FutureOr<void> deleteNoteEvent(
      DeleteNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.deleteNote(event.id);
      emit(NotesCRUDSuccessState());
    } catch (error) {
      emit(NotesCRUDErrorState(message: error.toString()));
    }
  }

  FutureOr<void> addNoteCategoryEvent(
      AddNoteCategoryEvent event, Emitter<NotesState> emit) async {
    await _notesCategoryRepository
        .insertNoteCategory(event.noteCategory)
        .then((value) => emit(NotesCategoryCRUDSuccessState()))
        .onError((error, stackTrace) =>
            emit(NotesCategoryCRUDErrorState(message: error.toString())));
  }

  FutureOr<void> updateNoteCategoryEvent(
      UpdateNoteCategoryEvent event, Emitter<NotesState> emit) {
    final result =
        _notesCategoryRepository.updateNoteCategory(event.noteCategory);
    result.then((value) => emit(NotesCategoryCRUDSuccessState())).onError(
        (error, stackTrace) =>
            emit(NotesCategoryCRUDErrorState(message: error.toString())));
  }

  FutureOr<void> deleteNoteCategoryEvent(
      DeleteNoteCategoryEvent event, Emitter<NotesState> emit) async {
    try {
      await _notesCategoryRepository.deleteNoteCategory(event.id);
      emit(NotesCategoryCRUDSuccessState());
    } catch (error) {
      emit(NotesCategoryCRUDErrorState(message: error.toString()));
    }
  }
}
