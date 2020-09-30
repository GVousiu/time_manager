import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:time_manager/utils/global.dart';
import 'package:time_manager/models/Todo.dart';

class Server {
  /// get the list of todos
  static List<TodoItemModel> getTodoListByDone(String status) {
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    if (status == 'pending' || status == 'done') {
      bool done = (status == 'done');
      List<TodoItemModel> _list = [];
      _todoList.forEach((element) {
        if (element.done == done) {
          _list.add(element);
        }
      });
      return _list;
    } else {
      return _todoList;
    }
  }

  /// change the status of todo
  static changeTodoStatus(TodoItemModel item) {
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    _todoList.forEach((element) {
      if (item.id == element.id) {
        element.done = !item.done;
      }
    });
    Global.saveTodoList(jsonEncode(_todoList));
  }

  /// change details of dodo
  static Future changeTodoDetails(TodoItemModel item) {
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    _todoList.forEach((element) {
      if (item.id == element.id) {
        element.detail = item.detail;
        element.title = item.title;
      }
    });
    return Global.saveTodoList(jsonEncode(_todoList));
  }

  /// add todo
  static addTodo({ @required String title, String detail }) {
    int id = Global.getTodoId() + 1;
    TodoItemModel item = TodoItemModel(id: id, title: title, done: false, detail: detail);
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    _todoList.add(item);
    Global.addTodo(jsonEncode(_todoList), id);
  }

  /// delete todo
  static Future deleteTodo({ @required TodoItemModel item }) {
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    for (int i = 0; i < _todoList.length; i++) {
      if (_todoList[i].id == item.id) {
        _todoList.removeAt(i);
      }
    }
    return Global.saveTodoList(jsonEncode(_todoList));
  }
}