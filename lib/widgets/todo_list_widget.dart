import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/mock/server.dart';
import 'package:todo_list/models/Todo.dart';
import 'package:todo_list/widgets/empty_widget.dart';
import 'package:todo_list/pages/todo_detail_page.dart';
import 'package:todo_list/widgets/todo_item_widget.dart';

class TodoListWidget extends StatefulWidget {
  final Key key;
  final String status;
  final String emptyMessage;

  TodoListWidget({
    this.key,
    this.status = '',
    this.emptyMessage = '',
  });

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoListWidget> {
  List<TodoItemModel> todoList = [];

  @override
  void initState() {
    super.initState();
    this.getTodoList();
  }

  /// 获取待办列表
  getTodoList() {
    var list = Server.getTodoListByDone(widget.status);
    setState(() {
      todoList = list;
    });
  }

  /// 修改当前待办的状态值
  onChangeStatus(TodoItemModel item) {
    Server.changeTodoStatus(item);
    this.getTodoList();
  }

  /// 跳转到详情页面
  viewDetail(BuildContext context, TodoItemModel item) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => TodoDetailPage(item: item),
    )).then((value) {
      this.getTodoList();
    });
  }

  /// 删除待办事项
  deleteItem(TodoItemModel item) {
    Server.deleteTodo(item: item).then((_) {
      this.setState(() {
        this.getTodoList();
      });
    });
  }

  /// 分隔符
  Widget _buildSeparator(BuildContext context, int index) {
    return Divider(
      color: Color(0xffefefef),
      thickness: 2.0,
      height: 2.0,
    );
  }

  /// 待办事项
  Widget _buildItem(BuildContext context, int index) {
    TodoItemModel item = todoList[index];
    return TodoItemWidget(
      item: TodoItemModel.fromJson(jsonDecode(json.encode(item))),
      onPressIcon: () { onChangeStatus(item); },
      onTapItem: () { viewDetail(context, item); },
      handleSlide: () { deleteItem(item); },
    );
  }

  @override
  Widget build(BuildContext context) {
    return todoList == null || todoList.length == 0
      ? EmptyWidget(message: widget.emptyMessage)
      : ListView.separated(
        itemBuilder: _buildItem,
        separatorBuilder: _buildSeparator,
        itemCount: todoList.length,
      );
  }
}