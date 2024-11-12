import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  static const _databaseName = 'MySimpleNotes.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS notes (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            category_id INTEGER NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS notes_categories (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL UNIQUE
          )
        ''');

        // Insert dummy data into `notes_categories`
        await db.insert('notes_categories', {'name': 'Personal'});
        await db.insert('notes_categories', {'name': 'Work'});

        // Insert dummy data into `notes`
        await db.insert('notes', {
          'title': 'Grocery List',
          'content': 'Buy milk, eggs, and bread.',
          'category_id': 1,
        });
        await db.insert('notes', {
          'title': 'Meeting Notes',
          'content': 'Discuss project milestones.',
          'category_id': 2,
        });
        await db.insert('notes', {
          'title': 'Daily Journal',
          'content': 'Reflect on today\'s progress.',
          'category_id': 1,
        });
      },
    );
  }
}
