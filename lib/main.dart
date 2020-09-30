import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_manager/utils/global.dart';
import 'package:time_manager/pages/container_page.dart';

void main() {
  /**
   * lastest flutter required you to call
   * WidgetsFlutterBinding.ensureInitialized();
   * before using any plugins if the code is executed before runApp.
   * Otherwise, you will receive an error:
   * ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
   */
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(MyApp()));
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '待办清单',
      /// 设置整个app的主题：颜色
      theme: ThemeData(
        // primarySwatch: Colors.green,
        primaryColor: Color(0xff617fdf),
      ),
      home: Scaffold(
        /// avoid overflow when keyboard opened
        resizeToAvoidBottomPadding: false,
        body: ContainerPage(),
      ),
    );
  }
}