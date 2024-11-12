part of 'fab_bloc.dart';

abstract class FabState extends Equatable {
  const FabState();

  @override
  List<Object> get props => [];
}

class FabInitial extends FabState {}

class NavigateToAddNotesFormSuccessState extends FabState {
  final List<NotesCategory> notesCategories;
  const NavigateToAddNotesFormSuccessState({required this.notesCategories});

  @override
  List<Object> get props => [];
}

class NotesCategoriesNotFoundState extends FabState {
  const NotesCategoriesNotFoundState();
  @override
  List<Object> get props => [];
}
