import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/Todo.dart';
import 'package:todo_list/style/font.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItemModel item;
  final onPressIcon;
  final onTapItem;
  final handleSlide;

  TodoItemWidget({
    @required this.item,
    @required this.onPressIcon,
    @required this.onTapItem,
    @required this.handleSlide,
  });

  @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  /// 用户按住不放是有个背景颜色的强调作用
  bool isTapOn = false;

  void handleTapDown(TapDownDetails details) {
    setState(() {
      isTapOn = true;
    });
  }
  
  void handleTapCancel() {
    setState(() {
      isTapOn = false;
    });
  }

  void handleOnTop() {
    handleTapCancel();
    widget.onTapItem();
  }

  void onPressIcon(TodoItemModel item) {
    /// delay the disappear of item, view as if has animation
    setState(() {
      item.done = !item.done;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      widget.onPressIcon();
    });
  }

  // build todo item content
  Widget _buildTodoContent() {
    return Container(
      color: isTapOn ? Colors.grey[100] : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(widget.item.done ? Icons.check_box : Icons.check_box_outline_blank),
              onPressed: (){ onPressIcon(widget.item); },
              color: widget.item.done ? Colors.grey : Colors.black,
            ),
            /// make the GestureDetector widget has max width
            Expanded(
              child: GestureDetector(
              onTap: handleOnTop,
              onTapDown: handleTapDown,
              onTapCancel: handleTapCancel,
              child: Text(
                widget.item.title,
                style: TEXT_FONT.copyWith(
                  decoration: widget.item.done ? TextDecoration.lineThrough : TextDecoration.none,
                  color: widget.item.done ? Colors.grey : Colors.black,
                ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

  // build background for dismissible
  Widget _buildBackground() {
    return Container(
      color: Color(0xFFEEEEEE),
      child: Icon(Icons.delete, color: Colors.red),
      alignment: Alignment.center,
    );
  }

  /// delete item in storage
  handleDismissed(_) {
    widget.handleSlide();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: new Key(jsonEncode(widget.item)),
      onDismissed: this.handleDismissed,
      direction: DismissDirection.endToStart,
      background: this._buildBackground(),
      child: this._buildTodoContent(),
    );
  }
}