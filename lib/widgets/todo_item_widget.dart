import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/models/Todo.dart';
import 'package:time_manager/style/font.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItemModel item;
  final onPressIcon;
  final onTapItem;
  final handleSlide;
  final handleDismissConfirm;

  TodoItemWidget({
    @required this.item,
    @required this.onPressIcon,
    @required this.onTapItem,
    @required this.handleSlide,
    this.handleDismissConfirm,
  });

  @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  /// 用户按住不放是有个背景颜色的强调作用
  bool isTapOn = false;
  bool done;

  @override
  void initState() {
    super.initState();
    this.done = widget.item.status == 'done';
  }

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
      this.done = !this.done;
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
              icon: Icon(this.done ? Icons.check_box : Icons.check_box_outline_blank),
              onPressed: (){ onPressIcon(widget.item); },
              color: this.done ? Color(0xFFBDBDBD) : Color(0xFF757575),
            ),
            /// make the GestureDetector widget has max width
            Expanded(
              child: GestureDetector(
                onTap: handleOnTop,
                onTapDown: handleTapDown,
                onTapCancel: handleTapCancel,
                child: Text(
                  widget.item.title,
                  overflow: TextOverflow.ellipsis,
                  style: TEXT_FONT.copyWith(
                    decoration: this.done ? TextDecoration.lineThrough : TextDecoration.none,
                    color: this.done ? Color(0xFFBDBDBD) : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // build background for dismissible
  Widget _buildBackground() {
    return Container(
      color: Color(0xFFEEEEEE),
      child: Icon(
        this.done ? Icons.check_box_outline_blank : Icons.check_box,
        color: Color(0xFFBDBDBD),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.0),
    );
  }

  Widget _buildSecondaryBackground() {
    return Container(
      color: Color(0xFFEEEEEE),
      child: Icon(Icons.delete, color: Colors.red),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 15.0),
    );
  }

  /// delete item in storage
  handleDismissed(DismissDirection direction) {
    widget.handleSlide(direction);
  }

  Future<bool> confirmDismiss(DismissDirection direction) {
    // return widget?.handleDismissConfirm(direction);
    if (widget.handleDismissConfirm != null) {
      return widget.handleDismissConfirm(direction);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: new Key(jsonEncode(widget.item)),
      confirmDismiss: this.confirmDismiss,
      onDismissed: this.handleDismissed,
      background: this._buildBackground(),
      secondaryBackground: this._buildSecondaryBackground(),
      child: this._buildTodoContent(),
    );
  }
}