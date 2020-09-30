import 'package:flutter/cupertino.dart';

class ScreenUtils {
  /// 获取屏幕宽度
  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 获取屏幕高度
  static screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}