import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'User.dart';

class Db {
  Future<Database> initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'class.db');

    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE users(id integer primary key autoincrement, 
lastName text, 
firstName text, 
gender text, 
address text, 
email text, 
dateOfBirth text, 
imageURL text, 
phoneNumber text )
''');
  }

  fillData(Database db, Users userList) async {
    userList.users?.forEach((user) async {
      int insertResult = await db.insert("users", user.convertToJSON());
    });
  }

  deleteUser(Database db, String attributeCompared, String condition) async {
    await db.query('DELETE FROM users WHERE $attributeCompared = $condition');
  }

  updateUser(Database db, String elementToUpdate, String attributeCompared,
      String condition) async {
    await db.query(
      'UPDATE users SET $elementToUpdate WHERE $attributeCompared = $condition',
    );
  }

  Future<List<Map<String, dynamic>>> getUsers(Database db) async {
    List<Map<String, dynamic>> users = await db.rawQuery('SELECT * FROM users');
    print("user List " + users.toString());
    return users;
  }

  clearDatabase(Database db) async {
    await db.execute("DELETE FROM users");
  }
}
