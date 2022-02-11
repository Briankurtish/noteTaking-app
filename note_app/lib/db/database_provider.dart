// making the db provider class

import 'package:note_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  Database _database;

  // creating the getter to the database
  Future<Database> get database async {
    // first check if we don't already have a db
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      // creating the first table
      await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date DATE
      )
      ''');
    }, version: 1);
  }

  // creating a function that will add a new note to our variable
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // creating the fuction that will fetch our database and return all the element inside the notes table

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db.query("notes");
    if (res.length == 0) {
      return Null;
    } else {
      var resultmap = res.toList();
      return resultmap.isEmpty ? resultmap : Null;
    }
  }
}
