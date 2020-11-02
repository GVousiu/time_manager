import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/logic/todo_logic.dart';
import 'package:time_manager/models/Todo.dart';
import 'package:time_manager/utils/global.dart';
import 'package:time_manager/widgets/empty_widget.dart';
import 'package:time_manager/pages/todo_detail_page.dart';
import 'package:time_manager/widgets/todo_item_widget.dart';

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

  /// fetch list
  getTodoList() async {
    TodoLogic.getTodoListByStatus(widget.status).then((value) {
      setState(() {
        this.todoList = value;
      });
    });
  }

  /// 修改当前待办的状态值
  onChangeStatus(TodoItemModel item) {
    TodoLogic.changeTodoStatus(item);
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

  /// show delete confirm dialog: double check, if user choose to double check before delete in setting page
  showDeleteDialog(TodoItemModel item) {
    return AlertDialog(
      content: Text('是否要删除该待办事项'),
      actions: [
        FlatButton(
          onPressed: () { Navigator.pop(context); },
          child: Text('取消'),
        ),
        FlatButton(
          onPressed: () { this.deleteItem(item); Navigator.pop(context); },
          child: Text('确定'),
        ),
      ],
    );
  }

  /// 删除待办事项
  deleteItem(TodoItemModel item) {
    TodoLogic.deleteTodo(item).then((value) {
      this.getTodoList();
    });
  }

  handleSlideItem(TodoItemModel item, DismissDirection direction) {
    /// slide item from left to right, will change item's status
    /// slide item from right to left, will delete item
    if (direction == DismissDirection.endToStart) {
      this.deleteItem(item);
    } else if (direction == DismissDirection.startToEnd) {
      this.onChangeStatus(item);
    }
  }

  /// 分隔符
  Widget _buildSeparator(BuildContext context, int index) {
    return Divider(
      color: Color(0xffefefef),
      thickness: 2.0,
      height: 2.0,
    );
  }

  /// handle dismiss confirm logic
  Future<bool> handleDismissConfirm(DismissDirection direction, TodoItemModel item) async {
    if (direction == DismissDirection.endToStart && Global.isDoubleCheck) {
      var isDismiss =  await showDialog(
        context: context,
        builder: (_) { return this.showDeleteDialog(item); },
      );
      return isDismiss;
    } else {
      return Future.value(true);
    }
  }

  /// 待办事项
  Widget _buildItem(BuildContext context, int index) {
    TodoItemModel item = todoList[index];
    return TodoItemWidget(
      item: TodoItemModel.fromJson(jsonDecode(json.encode(item))),
      onPressIcon: () { onChangeStatus(item); },
      onTapItem: () { viewDetail(context, item); },
      handleSlide: (DismissDirection direction) { handleSlideItem(item, direction); },
      handleDismissConfirm: (DismissDirection direction) { return handleDismissConfirm(direction, item); },
    );
  }

  /// called when user want to refresh the list
  Future handleRefresh() {
    this.getTodoList();
    return Future(() {
      this.getTodoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return todoList == null || todoList.length == 0
      ? EmptyWidget(message: widget.emptyMessage)
      : RefreshIndicator(
        child: ListView.separated(
          itemBuilder: _buildItem,
          separatorBuilder: _buildSeparator,
          itemCount: todoList.length,
        ),
        onRefresh: this.handleRefresh,
      );
  }
}