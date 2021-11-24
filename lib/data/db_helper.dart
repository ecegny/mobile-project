import 'dart:async';

import 'package:admin_control/models/admin.dart';
import 'package:admin_control/models/movie.dart';
import 'package:admin_control/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();

  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movie_app1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""CREATE TABLE admins(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        password TEXT
      )
      """);

    await db.execute("""CREATE TABLE admin_logins(
        name TEXT,
        password TEXT
        )
      """);

    await db.execute("""CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        movieName TEXT,
        description TEXT,
        actors TEXT,
        votes INTEGER,
        mark REAL
        )
      """);

    await db.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        fname TEXT,
        lname TEXT,
        email TEXT,
        password TEXT
      )
      """);

    await db.execute("""CREATE TABLE user_logins(
        fname TEXT,
        lname TEXT,
        email TEXT,
        password TEXT
        )
      """);
  }

  Future<int> insertAdmin(Admin admin) async {
    final db = await instance.database;

    //   var admins = await db.rawQuery("select * from admins where name = " + admin.name);
    // if (admins.isNotEmpty) {
    //   return -1;
    // }

    return await db.insert("admins", admin.toAdminMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<Admin?> checkAdminLogin(String name, String password) async {
    final db = await instance.database;
    var res = await db.rawQuery(
        "select * from admins where name = '$name' and password = '$password'");
    if (res.isNotEmpty) {
      List<dynamic> list =
          res.toList().map((c) => Admin.fromAdminMap(c)).toList();

      await db.insert("admin_logins", list[0].toAdminMap());
      return list[0];
    }
    return null;
  }

  // Future<int> getAdmin() async {
  //   final db = await instance.database;
  //   var logins = await db.rawQuery("select * from admin_logins");
  //   if (logins.isEmpty) return 0;
  //   return logins.length;
  // }

  Future<Admin> getAdminData() async {
    final db = await instance.database;
    var res = await db.rawQuery("select * from admin_logins");
    List<dynamic> list =
        res.toList().map((c) => Admin.fromAdminMap(c)).toList();
    return list[0];
  }

  Future<int> deleteAdmin(String name) async {
    final db = await instance.database;
    var logins =
        db.delete("admin_logins", where: "name = ?", whereArgs: [name]);
    return logins;
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await instance.database;

    return await db.insert("movies", movie.toMovieMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;

    return await db.insert("users", user.toUserMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<User?> checkUserLogin(String email, String password) async {
    final db = await instance.database;
    var res = await db.rawQuery(
        "select * from users where email = '$email' and password = '$password'");
    if (res.isNotEmpty) {
      List<dynamic> list =
          res.toList().map((c) => User.fromUserMap(c)).toList();

      await db.insert("user_logins", list[0].toUserMap());
      return list[0];
    }
    return null;
  }

  Future<User> getUserData() async {
    final db = await instance.database;
    var res = await db.rawQuery("select * from user_logins");
    List<dynamic> list = res.toList().map((c) => User.fromUserMap(c)).toList();
    return list[0];
  }

  Future<int> deleteUser(String email) async {
    final db = await instance.database;
    var logins =
        db.delete("user_logins", where: "email = ?", whereArgs: [email]);
    return logins;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
