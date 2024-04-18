import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "notes.db";
  final String noteTable =
      "CREATE TABLE notes(noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  final String users =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT)";

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
    });
  }

  Future<bool> login(Users user) async {
    final Database db = await initDb();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'userName = ? AND userPassword = ?',
      whereArgs: [user.userName, user.userPassword],
    );

    return result.isNotEmpty;
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDb();

    return db.insert('users', user.toMap());
  }




}