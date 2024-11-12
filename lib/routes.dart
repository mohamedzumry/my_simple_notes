import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_simple_notes/features/home/presentation/pages/home_page.dart';
import 'package:my_simple_notes/features/notes/domain/entities/note.dart';
import 'package:my_simple_notes/features/notes/presentation/pages/add_note.dart';
import 'package:my_simple_notes/features/notes/presentation/pages/edit_note.dart';
import 'package:my_simple_notes/features/notes/presentation/pages/notes_detail_page.dart';
import 'package:my_simple_notes/features/notes/presentation/pages/notes_list_page.dart';

class RouterConfiguration {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'add-note',
            name: 'addNote',
            builder: (context, state) {
              return const AddNote();
            },
          ),
          GoRoute(
            path: 'edit-note',
            name: 'editNote',
            builder: (context, state) {
              return const EditNote();
            },
          ),
          GoRoute(
            name: 'notesList',
            path: 'notes/:category/list',
            builder: (BuildContext context, GoRouterState state) {
              int id = int.parse(state.pathParameters['category']!);
              return NotesListPage(
                categoryId: id,
              );
            },
            routes: <RouteBase>[
              GoRoute(
                name: 'notesDetail',
                path: ':id',
                builder: (BuildContext context, GoRouterState state) {
                  Note note = state.extra! as Note;
                  return NotesDetailPage(
                    note: note,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
