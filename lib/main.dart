import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_notes/database/database_helper.dart';
import 'package:my_simple_notes/features/fab/presentation/bloc/fab_bloc.dart';
import 'package:my_simple_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_simple_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:my_simple_notes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database; // Initializes the database
  runApp(const MainApp());
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => NotesBloc()),
        BlocProvider(create: (context) => FabBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: RouterConfiguration().router,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldKey,
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.blueAccent,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            elevation: 3,
          ),
        ),
      ),
    );
  }
}
