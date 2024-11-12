import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/widgets/forms/edit_note_form.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      bloc: context.read<NotesBloc>(),
      builder: (context, state) {
        if (state is EditNotePageLoadedState) {
          return EditNoteForm(note: state.note);
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Note'),
            ),
            body: Center(
              child: Text(
                  'Something went wrong from our side, please contact support'),
            ));
      },
    );
  }
}
