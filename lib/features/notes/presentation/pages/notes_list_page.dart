import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_notes/features/fab/presentation/widgets/default_fab.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/widgets/notes_list_card.dart';
import 'package:go_router/go_router.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesBloc, NotesState>(
      bloc: context.read<NotesBloc>(),
      listener: (context, state) {
        if (state is NotesCategoryCRUDSuccessState) {
          context.goNamed('home');
          context.read<HomeBloc>().add(GetNotesCategoriesWithNoteCountEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note category deleted successfully'),
            ),
          );
        } else if (state is NotesCategoryCRUDErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<NotesBloc, NotesState>(
            bloc: context.read<NotesBloc>(),
            builder: (context, state) {
              if (state is NotesListLoadedState) {
                return Text(
                  state.notesCategory.name,
                );
              }
              return Text(
                'Category Name',
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                context
                    .read<NotesBloc>()
                    .add(DeleteNoteCategoryEvent(widget.categoryId));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<NotesBloc, NotesState>(
            bloc: context.read<NotesBloc>(),
            builder: (context, state) {
              if (state is NotesListLoadingState) {
                return const Center(
                    child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading Notes...')
                  ],
                ));
              } else if (state is NotesListLoadingErrorState) {
                return Center(
                    child: Text(state.message,
                        style: TextStyle(color: Colors.red)));
              } else if (state is NotesListLoadedState) {
                return GridView.builder(
                  itemCount: state.notesList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    final note = state.notesList[index];
                    return NotesListCard(
                      title: note.title,
                      content: note.content,
                      footer: note.updatedAt.toString(),
                      bgColor: Colors.blueAccent.withOpacity(0.3),
                      textColor: Colors.black,
                      onTap: () {
                        context.pushNamed(
                          'notesDetail',
                          pathParameters: {
                            'category': note.categoryId.toString(),
                            'id': note.id!.toString()
                          },
                          extra: note,
                        );
                      },
                    );
                  },
                );
              }
              return Center(
                  child: Text('No notes found',
                      style: TextStyle(color: Colors.red)));
            },
          ),
        ),
        floatingActionButton: DefaultFab(),
      ),
    );
  }
}
