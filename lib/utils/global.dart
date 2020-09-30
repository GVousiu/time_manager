import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/Todo.dart';

class Global {
  /// app本地存储内容，非持久性
  static SharedPreferences _prefs;
  /// 初始化的待办事项列表
  static List<TodoItemModel> todoList = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _list = _prefs.getString('todoList');
    if (_list == null) {
      _prefs.setString('todoList', jsonEncode(todoList));
      _prefs.setInt('todoId', todoList.length);
    }
  }

  /// 保存新的待办事项
  static Future saveTodoList(String list) async {
    return _prefs.setString('todoList', list);
  }

  /// 获取待办事项列表
  static String getTodoList() {
    var _string = _prefs.getString('todoList');
    return _string == null ? '' : _string;
  }

  /// 添加待办事项：保存列表，保存新的id值
  static Future addTodo(String list, int todoId) {
    saveTodoList(list);
    return _prefs.setInt('todoId', todoId);
  }

  /// 获取当前待办事项的id值
  static int getTodoId() {
    return _prefs.getInt('todoId');
  }
}