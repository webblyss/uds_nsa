import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginDb {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "login.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE login(id INTEGER PRIMARY KEY autoincrement, firstName TEXT, lastName TEXT, indexNumber TEXT)",
        );
      });
    }
  }

  Future<int> insertStudent(LoginItem student) async {
    await openDb();
    return await _database.insert('login', student.toMap());
  }

  Future<List<LoginItem>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('login');
    return List.generate(maps.length, (i) {
      return LoginItem(
          id: maps[i]['id'], firstName: maps[i]['firstName'], lastName: maps[i]['lastName'],indexNumber: maps[i]['lastName']);
    });
  }

  Future<int> updateStudent(LoginItem login) async {
    await openDb();
    return await _database.update('login', login.toMap(),
        where: "id = ?", whereArgs: [login.id]);
  }

  Future<void> deleteStudent(int id) async {
    await openDb();
    await _database.delete('login', where: "id = ?", whereArgs: [id]);
  }
}

class LoginItem {
  int id;
  String firstName;
  String lastName;
  String indexNumber;
  LoginItem({@required this.firstName, @required this.indexNumber,@required this.lastName, this.id});
  Map<String, dynamic> toMap() {
    return {'firstName': firstName, 'lastName': lastName,'indexNumber': indexNumber};
  }
}
