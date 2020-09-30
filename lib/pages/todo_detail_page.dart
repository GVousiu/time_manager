import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/mock/server.dart';
import 'package:time_manager/models/Todo.dart';
import 'package:time_manager/style/font.dart';
import 'package:time_manager/style/style.dart';

class TodoDetailPage extends StatefulWidget {
  final TodoItemModel item;

  TodoDetailPage({ @required this.item });

  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetailPage> {
  TextEditingController _detailTextController;
  String _detail = '';
  
  @override
  void initState() {
    super.initState();
    /// 初始化状态：输入框默认值为当前待办原来的详情
    this._detail = widget?.item?.detail;
    this._detailTextController = TextEditingController(text: this._detail);
  }

  saveChange() {
    /// save detail change when exit this page
    /// go back util the changes have been saved
    /// make it feel like auto save
    widget.item.detail = this._detailTextController.text;
    Server.changeTodoDetails(widget.item).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.item?.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () { this.saveChange(); },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        /// 普通输入框
        child: TextField(
          style: TEXT_FONT,
          controller: this._detailTextController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 1,
          decoration: INPUT_DECORATION.copyWith(
            hintText: '描述',
          ),
        ),
      ),
    );
  }
}