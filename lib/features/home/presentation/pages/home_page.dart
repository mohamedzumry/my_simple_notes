import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:my_simple_notes/features/fab/presentation/widgets/default_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';
import '../widgets/folder_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(GetNotesCategoriesWithNoteCountEvent());
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<HomeBloc>().add(GetNotesCategoriesWithNoteCountEvent());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Simple Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: context.read<HomeBloc>(),
          builder: (context, state) {
            if (state is NotesCategoriesWithNoteCountLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesCategoriesWithNoteCountLoadingErrorState) {
              return Center(
                  child: Text(state.error,
                      style: const TextStyle(color: Colors.red)));
            } else if (state is NotesCategoriesWithNoteCountLoadedState) {
              return ListView.builder(
                itemCount: state.notesCategoriesWithNoteCountList.length,
                itemBuilder: (context, index) {
                  final category =
                      state.notesCategoriesWithNoteCountList[index];
                  return FolderTile(
                    title: category.name,
                    noteCount: '${category.noteCount} notes',
                    onTap: () {
                      context.pushNamed(
                        'notesList',
                        pathParameters: {
                          'category': category.id.toString(),
                        },
                      );
                      context
                          .read<NotesBloc>()
                          .add(NaviagteToNotesListPageEvent(category.id));
                    },
                  );
                },
              );
            }
            return Center(
              child: Text(
                'Something went wrong, please try again later or contact support',
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: DefaultFab(),
    );
  }
}
