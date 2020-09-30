import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/widgets/todo_list_widget.dart';

class DoneListPage extends StatefulWidget {
  DoneListPage({Key key}): super(key: key);

  @override
  _DoneListPageState createState() => _DoneListPageState();
}

class _DoneListPageState extends State<DoneListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('已办事项'),
        centerTitle: true,
      ),
      body:  Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: TodoListWidget(
          status: 'done',
          emptyMessage: '还没有已办事项，快去添加吧~',
        ),
      ),
    );
  }
}