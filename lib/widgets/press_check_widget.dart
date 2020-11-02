import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PressCheckWidget extends StatefulWidget {
  final bool isCheck;
  final Color checkColor;
  final Widget child;
  final handlePressCheck;
  final onTap;
  final onTapDown;
  final onTapCancel;

  PressCheckWidget({
    @required this.isCheck,
    @required this.child,
    @required this.handlePressCheck,
    this.checkColor,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
  });
  
  @override
  _PressCheckState createState() => _PressCheckState();
}

class _PressCheckState extends State<PressCheckWidget> {
  bool _isTapOn = false;

  @override
  void initState() {
    super.initState();
  }

  handlePressIcon() {
    if (widget.handlePressCheck != null) {
      widget.handlePressCheck();
    }
  }

  _handleTap() {
    setState(() {
      _isTapOn = false;
    });
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTapOn = true;
    });
    if (widget.onTapDown != null) {
      widget.onTapDown();
    }
  }

  _handleTapCancel() {
    setState(() {
      _isTapOn = false;
    });
    if (widget.onTapCancel != null) {
      widget.onTapCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isTapOn ? Colors.grey[100] : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                widget.isCheck ? Icons.check_box : Icons.check_box_outline_blank,
                color: widget.isCheck ? (widget.checkColor ?? Theme.of(context).primaryColor) : Color(0xFF757575),
              ),
              onPressed: this.handlePressIcon,
            ),
            Expanded(
              child: GestureDetector(
                onTap: this._handleTap,
                onTapDown: this._handleTapDown,
                onTapCancel: this._handleTapCancel,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}