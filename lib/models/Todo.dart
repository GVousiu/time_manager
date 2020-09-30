
import 'package:flutter/cupertino.dart';

class TodoItemModel {
  final String title;
  String detail;
  final int id;
  bool done;

  TodoItemModel({
    @required this.id,
    @required this.title,
    @required this.done,
    this.detail
  });

  @override
  String toString() {
    return '$title---$done---$detail';
  }

  /// 将实体类转成json类型的时候调用：jsonEncode
  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map['title'] = this.title;
    map['detail'] = this.detail;
    map["done"] = this.done;
    return map;
  }

  /// 将json转成待办事项实体类类型TodoItemModel
  static fromJson(dynamic json) {
    return TodoItemModel(
      title: json['title'],
      detail: json['detail'],
      id: json['id'],
      done: json['done'],
    );
  }

  /// 将待办事项列表的数组从json转成TodoItemModel类型
  static listFromJson(List json) {
    /// should add type for map to avoid error: type cast error
    return json.map<TodoItemModel>((item) => TodoItemModel.fromJson(item)).toList();
  }
}