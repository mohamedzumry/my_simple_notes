import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_notes/features/home/domain/entities/notes_category_with_note_count_model.dart';
import 'package:my_simple_notes/features/notes/data/repositories/sql_notes_repository.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NotesRepository _notesRepository = SqlNotesRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetNotesCategoriesWithNoteCountEvent>(
        getNotesCategoriesWithNoteCountEvent);
  }

  FutureOr<void> getNotesCategoriesWithNoteCountEvent(
      GetNotesCategoriesWithNoteCountEvent event,
      Emitter<HomeState> emit) async {
    emit(NotesCategoriesWithNoteCountLoadingState());
    try {
      final notesCategoriesWithNoteCount =
          await _notesRepository.getNotesCategoriesWithNoteCount();
      emit(NotesCategoriesWithNoteCountLoadedState(
          notesCategoriesWithNoteCount));
    } catch (error) {
      emit(NotesCategoriesWithNoteCountLoadingErrorState(error.toString()));
    }
  }
}
