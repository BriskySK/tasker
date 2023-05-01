import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasker/domain/db_model.dart';
import 'package:tasker/domain/task.dart';

class DbHelper {
  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE $tableTasks (
     ${TaskFields.id} $idType,
     ${TaskFields.title} $stringType,
     ${TaskFields.description} $stringType,
     ${TaskFields.dueDate} $stringType,
     ${TaskFields.completed} $boolType
     )''');
  }

  Future<int> create(Task task) async {
    Database db = await instance.database;
    return await db.insert(tableTasks, task.toJson());
  }

  Future<List<Task>> readAll() async {
    final db = await instance.database;
    final results = await db.query(tableTasks, orderBy: '${TaskFields.dueDate} ASC');
    return results.map((e) => Task.fromJson(e)).toList();
  }

  Future<Task?> readOne(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableTasks,
        columns: TaskFields.values, where: '${TaskFields.id}=?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Task.fromJson(maps.first);
    } else {
      throw Exception('ID: $id was not found');
    }
  }

  Future<int> edit(Task task) async {
    final db = await instance.database;
    return db.update(tableTasks, task.toJson(), where: '${TaskFields.id}=?', whereArgs: [task.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableTasks, where: '${TaskFields.id}=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
