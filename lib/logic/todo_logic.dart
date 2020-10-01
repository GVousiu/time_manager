import 'package:time_manager/database/database_helper.dart';
import 'package:time_manager/models/Todo.dart';

/// handle logic between database and view: for example, data convert
class TodoLogic {
  /// get todo list from database and change into a list
  static Future<List<TodoItemModel>> getTodoListByStatus(String status) async {
    return DbHelper.db.getTodoListByStatus(status: status).then((value) {
      List<TodoItemModel> result = TodoItemModel.listFromJson(value);
      return result;
    });
  }

  /// change todo item's status: whether complete 
  static Future changeTodoStatus(TodoItemModel item) async {
    switch(item.status) {
      case 'pending': item.status = 'done'; break;
      case 'done': item.status = 'pending'; break;
      default: return;
    }
    await DbHelper.db.updateTodo(newValue: item.toJson(), id: item.id);
  }
  
  /// modify todo item's detail and title
  static Future changeTodoDetail(TodoItemModel item) {
    return DbHelper.db.updateTodo(newValue: item.toJson(), id: item.id);
  }

  /// delete todo item in logic: by change its status to delete
  static Future deleteTodo(TodoItemModel item) async {
    if (item.status != 'pending' && item.status != 'done') {
      return;
    }
    item.status = 'delete';
    return DbHelper.db.updateTodo(newValue: item.toJson(), id: item.id);
  }

  /// add a todo to database
  static Future addTodo(TodoItemModel item) {
    return DbHelper.db.addTodo(item.toJson()).then((value) {
      return item.id = value;
    });
  }
}