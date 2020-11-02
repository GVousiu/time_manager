import 'package:flutter/material.dart';
import 'package:time_manager/utils/global.dart';

class AppInfo with ChangeNotifier {
  String _themeColor = Global.themeColor;

  String get themeColor => _themeColor;

  void setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
