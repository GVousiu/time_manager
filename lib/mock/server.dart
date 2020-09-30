import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/utils/global.dart';
import 'package:todo_list/models/Todo.dart';

class Server {
  /// 获取待办事项列表
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

  /// 改变待办事项的状态值
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

  /// 修改待办事项的详情
  static Future changeTodoDetails(TodoItemModel item) {
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    _todoList.forEach((element) {
      if (item.id == element.id) {
        element.detail = item.detail;
      }
    });
    return Global.saveTodoList(jsonEncode(_todoList));
  }

  /// 增加待办事项
  static addTodo({ @required String title }) {
    int id = Global.getTodoId() + 1;
    TodoItemModel item = TodoItemModel(id: id, title: title, done: false);
    var _todoListJson = Global.getTodoList();
    List<TodoItemModel> _todoList = TodoItemModel.listFromJson(jsonDecode(_todoListJson));
    _todoList.add(item);
    Global.addTodo(jsonEncode(_todoList), id);
  }

  /// 删除待办事项
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