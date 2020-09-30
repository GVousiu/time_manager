import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:todo_list/mock/server.dart';
import 'package:todo_list/style/font.dart';

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodoPage> {
  final _titleController = new TextEditingController();
  final _detailController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// 悬浮按钮的回调方法
  handlePressSendBtn(BuildContext context) {
    String title = this._titleController.text;
    if (_formKey.currentState.validate()) {
      Server.addTodo(title: title);
      Navigator.pop(context);
    }
  }

  /// 输入框的验证：非空校验
  validateInputNotEmpty(value) {
    if (isEmpty(value)) {
      return '请填写';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加待办事项'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// form表单输入框，带验证功能
              TextFormField(
                /// 输入框输入内容字体样式
                style: TEXT_FONT.copyWith(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(
                  /// 错误提示的字体样式
                  errorStyle: ERROR_TEXT_FONT,
                  hintText: '准备做什么？',
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
                validator: (value) => this.validateInputNotEmpty(value),
                maxLines: 1,
                minLines: 1,
              ),
              Container(
                margin: EdgeInsets.only(top:13.0),
                child: TextField(
                  style: TEXT_FONT,
                  controller: _detailController,
                  decoration: InputDecoration(
                    hintText: '描述',
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                  ),
                  maxLines: 10,
                  minLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      /// 屏幕右下角的悬浮按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () { this.handlePressSendBtn(context); },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}