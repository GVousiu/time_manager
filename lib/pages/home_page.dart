import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/add_todo_page.dart';
import 'package:todo_list/widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Key key = UniqueKey();

  /// change key of todoList to make it reload, and get the lastest list
  void reload() {
    setState(() {
      key = UniqueKey();
    });
  }

  /// 跳转到添加待办页面，返回时强制刷新当前页面的待办事项列表
  handlePressAddButton(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    ))
    .then((value) {
      this.reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('待办事项'),
        /// android需要手动控制上方标题栏的对齐方式，默认靠左对齐
        centerTitle: true,
      ),
      body:  Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: TodoListWidget(
          key: key,
          status: 'pending',
          emptyMessage: '还没有待办事项，快去添加吧~',
        ),
      ),
      /// 右下角的悬浮按钮：跳转到添加待办页面
      floatingActionButton: FloatingActionButton(
        onPressed: () { this.handlePressAddButton(context); },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}