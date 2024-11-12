import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_notes/features/notes/data/repositories/sql_notes_category_repository.dart';
import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';
import 'package:my_simple_notes/features/notes/domain/repositories/notes_category_repository.dart';

part 'fab_event.dart';
part 'fab_state.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  final NotesCategoryRepository _notesCategoryRepository =
      SqlNotesCategoryRepository();

  FabBloc() : super(FabInitial()) {
    on<FabEvent>((event, emit) {});
    on<NavigateToAddNotesFormEvent>(navigateToAddNotesFormEvent);
  }

  FutureOr<void> navigateToAddNotesFormEvent(
      NavigateToAddNotesFormEvent event, Emitter<FabState> emit) async {
    final noteCategories = await _notesCategoryRepository.getNoteCategories();
    if (noteCategories.isEmpty) {
      emit(NotesCategoriesNotFoundState());
    } else {
      emit(NavigateToAddNotesFormSuccessState(notesCategories: noteCategories));
    }
  }
}
