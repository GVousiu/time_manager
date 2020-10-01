import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:time_manager/database/create.dart';
import 'package:time_manager/models/Todo.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper db = DbHelper._();

  Database _database;

  /// get function to get private variable: _database
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  /// init database info
  initDatabase() async {
    var _databasePath = await getDatabasesPath();
    String path = join(_databasePath, 'time_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (database) {},
      onCreate: this.createDatabase,
      onUpgrade: this.handleUpgardeDatabase,
    );
  }

  /// create a database: create tables
  createDatabase(Database db, int version) async {
    await db.execute(CREATE_TODO_TABLE);
  }

  /// handle the database upgrade: currently useless
  handleUpgardeDatabase(Database db, int oldVersion, int newVersion) async {
  }

  /// add a todo item to database
  Future addTodo(Map<String, dynamic> itemJson) async {
    final db = await database;
    return await db.insert('todo', itemJson);
  }

  /// get todo list by status
  Future getTodoListByStatus({ String status }) async {
    final db = await database;
    return db.query(
      'todo',
      where: '''status = ?''',
      whereArgs: [status],
    );
  }

  /// update a todo: status, title, detail
  Future updateTodo({Map newValue, int id}) async {
    if (TodoItemModel == null) {
      return;
    }
    final db = await database;
    return db.update('todo', newValue,
      where: 'id=?',
      whereArgs: [id],
    );
  }
}