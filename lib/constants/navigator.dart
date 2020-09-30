import 'package:flutter/material.dart';

/// 屏幕下方导航栏
const List<_Item> BOTTOM_NAVIGATOR_ITEM_LIST = [
  _Item(title: '首页', icon: Icons.home),
  _Item(title: '已完成', icon: Icons.playlist_add_check),
];

class _Item {
  final String title;
  final IconData icon;

  const _Item({@required this.title, @required this.icon});
}