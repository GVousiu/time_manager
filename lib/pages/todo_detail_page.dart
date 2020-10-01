import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:time_manager/logic/todo_logic.dart';
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
  TextEditingController _titleTextController;
  String _appBarTitle;
  
  @override
  void initState() {
    super.initState();
    /// initial state: todo item's title and detail will be set in the TextField
    this._detailTextController = TextEditingController(text: widget?.item?.detail);
    this._titleTextController = TextEditingController(text: widget?.item?.title);
    _appBarTitle = widget?.item?.title;
  }

  saveChange() {
    /// save detail change when exit this page
    /// go back util the changes have been saved
    /// make it feel like auto save
    widget.item.detail = this._detailTextController.text;
    widget.item.title = this._titleTextController.text;
    TodoLogic.changeTodoDetail(widget.item).then((_) {
      Navigator.pop(context);
    });
  }

  /// to valid the title input: required
  validateInputNotEmpty(value) {
    if (isEmpty(value)) {
      return '请填写';
    }
    return null;
  }

  Widget _buildDetailInput() {
    return TextField(
      style: TEXT_FONT,
      controller: this._detailTextController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 1,
      decoration: INPUT_DECORATION.copyWith(
        hintText: '描述',
      ),
    );
  }

  handleChangeTitle(String changedTitle) {
    this.setState(() {
      this._appBarTitle = changedTitle;
    });
  }

  Widget _buildTitleInput() {
    return TextFormField(
      style: TEXT_FONT.copyWith(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
      ),
      onChanged: this.handleChangeTitle,
      controller: _titleTextController,
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
        title: Text(this._appBarTitle),
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
        child: Column(
          children: [
            this._buildTitleInput(),
            this._buildDetailInput(),
          ],
        ),
      ),
    );
  }
}