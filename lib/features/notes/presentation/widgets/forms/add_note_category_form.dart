import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/domain/entities/notes_category.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';

class AddNoteCategoryForm extends StatefulWidget {
  const AddNoteCategoryForm({super.key});

  @override
  State<AddNoteCategoryForm> createState() => _AddNoteCategoryFormState();
}

class _AddNoteCategoryFormState extends State<AddNoteCategoryForm> {
  final GlobalKey<FormState> _addCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NotesCategoryCRUDSuccessState) {
          context.pop();
          context.read<HomeBloc>().add(GetNotesCategoriesWithNoteCountEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category added successfully'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Add Category'),
          actions: [
            IconButton(
              onPressed: () {
                if (_addCategoryFormKey.currentState!.validate()) {
                  context.read<NotesBloc>().add(AddNoteCategoryEvent(
                      NotesCategory(name: _titleController.text)));
                }
              },
              icon: const Icon(Icons.save),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.cancel),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _addCategoryFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
