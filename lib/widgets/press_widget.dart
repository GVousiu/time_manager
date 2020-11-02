import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PressWidget extends StatefulWidget {
  final Widget child;
  final onTap;
  final onTapDown;
  final onTapCancel;
  final padding;

  PressWidget({
    @required this.child,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.padding,
  });

  @override
  _PressState createState() => _PressState();
}

class _PressState extends State<PressWidget> {
  bool _isTap = false;

  _handleTap() {
    setState(() {
      _isTap = false;
    });
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTap = true;
    });
    if (widget.onTapDown != null) {
      widget.onTapDown();
    }
  }

  _handleTapCancel() {
    setState(() {
      _isTap = false;
    });
    if (widget.onTapCancel != null) {
      widget.onTapCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this._handleTap,
      onTapDown: this._handleTapDown,
      onTapCancel: this._handleTapCancel,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: widget.padding,
              color: _isTap ? Colors.grey[100] : Colors.transparent,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}