import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';
import '../../../../fab/presentation/bloc/fab_bloc.dart';

class EditNoteForm extends StatefulWidget {
  final Note note;
  const EditNoteForm({super.key, required this.note});

  @override
  State<EditNoteForm> createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  final GlobalKey<FormState> _addNoteFormKey = GlobalKey<FormState>();

  late TextEditingController _titleController;

  late TextEditingController _contentController;

  late int _selectedNoteCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedNoteCategory = widget.note.categoryId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

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
              content: Text('Note updated successfully'),
            ),
          );
        } else if (state is NotesCRUDErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Edit Note'),
          actions: [
            IconButton(
              onPressed: () {
                if (_addNoteFormKey.currentState!.validate()) {
                  context.read<NotesBloc>().add(
                        UpdateNoteEvent(
                          Note(
                            id: widget.note.id,
                            title: _titleController.text,
                            content: _contentController.text,
                            categoryId: _selectedNoteCategory,
                          ),
                        ),
                      );
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
            child: BlocBuilder<FabBloc, FabState>(
              bloc: context.read<FabBloc>(),
              builder: (context, state) {
                if (state is NotesCategoriesNotFoundState) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'No categories found, add a category first to continue...',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is NavigateToAddNotesFormSuccessState) {
                  return Form(
                    key: _addNoteFormKey,
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
                        const SizedBox(height: 16),
                        DropdownButtonFormField(
                          value: _selectedNoteCategory,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category',
                          ),
                          items: [
                            for (var category in state.notesCategories)
                              DropdownMenuItem(
                                value: category.id,
                                child: Text(category.name),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedNoteCategory = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Category is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _contentController,
                          minLines: 15,
                          maxLines: 25,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Content',
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text(
                      'Something went wrong, please contact support. Sorry for the inconvenience.'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
