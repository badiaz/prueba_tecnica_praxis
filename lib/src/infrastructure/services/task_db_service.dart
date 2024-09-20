import 'package:path/path.dart';
import 'package:praxis_tareas_app/src/domain/entities/task_entity.dart';
import 'package:sqflite/sqflite.dart';

class TaskDBService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            completed INTEGER
          )
        ''');
      },
    );
  }

  Future<List<TaskEntity>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((task) => TaskEntity.fromJson(task)).toList();
  }

  Future<void> insertTask(TaskEntity task) async {
    final db = await database;
    await db.insert('tasks', task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTaskCompleted(int id, bool completed) async {
    final db = await database;
    await db.update(
      'tasks',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
