import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  /// app本地存储内容，非持久性
  static SharedPreferences _prefs;
  static bool _isDoubleCheck;
  static String _themeColor;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    _isDoubleCheck = _prefs.getBool('isDoubleCheck') ?? false;
    _themeColor = _prefs.getString('themeColor') ?? '0xff617fdf';
  }

  static get isDoubleCheck {
    return _isDoubleCheck;
  }

  static get themeColor {
    return _themeColor;
  }

  static changeIsDoubleCheck(bool isDoubleCheck) async {
    _isDoubleCheck = isDoubleCheck;
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isDoubleCheck', isDoubleCheck);
  }

  static changeThemeColor(String newColor) async {
    _themeColor = newColor;
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('themeColor', newColor);
  }
}