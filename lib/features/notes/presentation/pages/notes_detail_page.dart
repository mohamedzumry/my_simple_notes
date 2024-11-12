import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_simple_notes/features/fab/presentation/bloc/fab_bloc.dart';
import 'package:my_simple_notes/features/fab/presentation/widgets/default_fab.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';

class NotesDetailPage extends StatefulWidget {
  const NotesDetailPage({super.key, required this.note});

  final Note note;

  @override
  State<NotesDetailPage> createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesBloc, NotesState>(
      bloc: context.read<NotesBloc>(),
      listener: (context, state) {
        if (state is NotesCRUDSuccessState) {
          context.goNamed('home');
          context.read<HomeBloc>().add(GetNotesCategoriesWithNoteCountEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note deleted successfully'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes Detail'),
          actions: [
            IconButton(
              onPressed: () {
                context.goNamed('editNote');
                context.read<NotesBloc>().add(EditNoteEvent(widget.note));
                context.read<FabBloc>().add(NavigateToAddNotesFormEvent());
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.yellow),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<NotesBloc>().add(DeleteNoteEvent(widget.note.id!));
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.yellow,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Updated: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.note.createdAt!)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  widget.note.content,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: DefaultFab(),
      ),
    );
  }
}
