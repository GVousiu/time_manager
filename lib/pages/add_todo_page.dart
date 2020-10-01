import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:time_manager/logic/todo_logic.dart';
import 'package:time_manager/models/Todo.dart';
import 'package:time_manager/style/font.dart';
import 'package:time_manager/style/style.dart';

class AddTodoPage extends StatefulWidget {
  final String title;
  final String detail;

  AddTodoPage({
    this.title = '',
    this.detail = '',
  });

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodoPage> {
  final _titleController = new TextEditingController();
  final _detailController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    this._titleController.text = widget.title;
    this._detailController.text = widget.detail;
  }

  /// 悬浮按钮的回调方法
  handlePressSendBtn(BuildContext context) {
    String title = this._titleController.text;
    String detail = this._detailController.text;
    if (_formKey.currentState.validate()) {
      final item = TodoItemModel(title: title, detail: detail, status: 'pending');
      TodoLogic.addTodo(item).then((value) {
        Navigator.pop(context);
      });
    }
  }

  /// to valid the title input: required
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
        maxLines: null,
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
      maxLengthEnforced: true,
      decoration: INPUT_DECORATION.copyWith(
        hintText: '准备做什么？',
      ),
      validator: (value) => this.validateInputNotEmpty(value),
      maxLines: null,
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