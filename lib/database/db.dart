import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasker/database/db_model.dart';
import 'package:tasker/database/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _db;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('tasks.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
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
         ${TaskFields.completed} $boolType,
         )''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;

    final id = await db.insert(tableTasks, task.toJson());
    return task.copy(id: id);
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

  Future<List<Task>> readAll() async {
    final db = await instance.database;
    final results = await db.query(tableTasks,orderBy: '${TaskFields.dueDate} ASC');
  return results.map((e) => Task.fromJson(e)).toList();
  }

  Future<int> edit(Task task)async{
    final db = await instance.database;
    return db.update(tableTasks, task.toJson(), where: '${TaskFields.id}=?', whereArgs: [task.id]);
  }

  Future<int> delete(int id)async{
    final db = await instance.database;

    return await db.delete(tableTasks, where: '${TaskFields.id}=?', whereArgs: [id] );
  }
  
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
