
import '../JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "notes.db";
  String noteTable= "CREATE TABLE notes(noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContext TEXT NOT NULL";

  String users = "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQE, userPassword TEXT)";
  Future<Database> initDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,databaseName);

    return openDatabase(path,version:1,onCraeate:(db, version) async{0
      await db.execute(users);
      await db.execute(noteTable);
    });
  }

  // Login Method
    Future<bool> login(Users user) async {
      final Database db = await initDb();
      var result = await db.rawQuery(
          "select * from users where username ='${user.userName}' AND '${user
              .userPassword}'");
      if (result.isNotEmpt y) {
        return true;
      } else {
        return false;
      }
    }

  // Sign up
    Future<int> signup(Users user) async {
      final Database db = new
      await initDb();

      return db.insert('users', user.toMap());
    }


}

class Database {
}