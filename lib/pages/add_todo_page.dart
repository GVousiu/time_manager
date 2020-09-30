import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:todo_list/mock/server.dart';
import 'package:todo_list/style/font.dart';
import 'package:todo_list/style/style.dart';

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

  /// build input for detail
  Widget _buildDetailInput() {
    return Container(
      margin: EdgeInsets.only(top:13.0),
      child: TextField(
        style: TEXT_FONT,
        controller: _detailController,
        decoration: INPUT_DECORATION.copyWith(
          hintText: '描述',
        ),
        maxLines: 10,
        minLines: 1,
      ),
    );
  }

  /// build input for title
  Widget _buildTitleInput() {
    return TextFormField(
      style: TEXT_FONT.copyWith(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
      ),
      controller: _titleController,
      autofocus: true,
      decoration: INPUT_DECORATION.copyWith(
        hintText: '准备做什么？',
      ),
      validator: (value) => this.validateInputNotEmpty(value),
      maxLines: 1,
      minLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加待办事项'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              this._buildTitleInput(),
              this._buildDetailInput()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () { this.handlePressSendBtn(context); },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}