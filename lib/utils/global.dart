import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  /// app本地存储内容，非持久性
  static SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}