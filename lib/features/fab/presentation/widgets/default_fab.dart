import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:my_simple_notes/features/fab/presentation/bloc/fab_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/widgets/forms/add_note_category_form.dart';

class DefaultFab extends StatefulWidget {
  const DefaultFab({super.key});

  @override
  State<DefaultFab> createState() => _DefaultFabState();
}

class _DefaultFabState extends State<DefaultFab> {
  final _key = GlobalKey<ExpandableFabState>();

  void naviagetToAddNotePage(BuildContext context) {
    toggleFab();
    context.goNamed('addNote');
    context.read<FabBloc>().add(NavigateToAddNotesFormEvent());
  }

  void showAddNoteCategoryForm(BuildContext context) {
    toggleFab();
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: AddNoteCategoryForm(),
      ),
    );
  }

  void toggleFab() {
    _key.currentState?.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.rotate,
      duration: const Duration(milliseconds: 750),
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(0.5),
      ),
      children: [
        Row(
          children: [
            Text('Create Note'),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: 'createNote',
              onPressed: () {
                naviagetToAddNotePage(context);
              },
              child: Icon(Icons.add_task),
            ),
          ],
        ),
        Row(
          children: [
            Text('Create Category'),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: 'createCategory',
              onPressed: () {
                showAddNoteCategoryForm(context);
              },
              child: Icon(Icons.add_comment_outlined),
            ),
          ],
        ),
        Row(
          children: [
            Text('Home'),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: 'home',
              onPressed: () {
                context.goNamed('home');
              },
              child: Icon(Icons.home),
            ),
          ],
        ),
      ],
    );
  }
}
