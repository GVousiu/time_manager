
import 'package:flutter/cupertino.dart';

class TodoItemModel {
  String title;
  String detail;
  int id;
  /// pending, done, delete
  String status;

  TodoItemModel({
    this.id,
    @required this.title,
    this.detail,
    @required this.status,
  });

  @override
  String toString() {
    return '$title---$status---$detail';
  }

  /// invoke when change instance to a json type using jsonEncode
  Map toJson() {
    Map map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = this.title;
    map['detail'] = this.detail;
    map['status'] = this.status;
    return map;
  }

  /// change json variable to a TodoItemModel instance
  static fromJson(dynamic json) {
    return TodoItemModel(
      title: json['title'],
      detail: json['detail'],
      id: json['id'],
      // done: json['done'],
      status: json['status'],
    );
  }

  /// change list from json type to TodoItemModel type
  static listFromJson(List json) {
    /// should add type for map to avoid error: type cast error
    return json.map<TodoItemModel>((item) => TodoItemModel.fromJson(item)).toList();
  }
}