part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeActionState extends HomeState {
  const HomeActionState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class NotesCategoriesWithNoteCountLoadingState extends HomeState {
  const NotesCategoriesWithNoteCountLoadingState();

  @override
  List<Object> get props => [];
}

class NotesCategoriesWithNoteCountLoadedState extends HomeState {
  final List<NotesCategoryWithNoteCountModel> notesCategoriesWithNoteCountList;
  const NotesCategoriesWithNoteCountLoadedState(
      this.notesCategoriesWithNoteCountList);

  @override
  List<Object> get props => [notesCategoriesWithNoteCountList];
}

class NotesCategoriesWithNoteCountLoadingErrorState extends HomeState {
  final String error;
  const NotesCategoriesWithNoteCountLoadingErrorState(this.error);

  @override
  List<Object> get props => [error];
}
