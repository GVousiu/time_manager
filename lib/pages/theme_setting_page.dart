import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_manager/constants/setting.dart';
import 'package:time_manager/provider/app_info.dart';
import 'package:time_manager/style/font.dart';
import 'package:time_manager/utils/global.dart';
import 'package:time_manager/utils/screen_utils.dart';

class ThemeSettingPage extends StatefulWidget {
  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSettingPage> {
  // change theme color
  _handleOnTap(String color, AppInfo appInfo) {
    Global.changeThemeColor(color);
    appInfo.setTheme(color);
  }

  _handleCustomColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  maxLines: 1,
                  minLines: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: 22.0,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () { Navigator.pop(context); },
              child: Text('取消'),
            ),
            FlatButton(
              onPressed: () { Navigator.pop(context); },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem({@required String color, String title}) {
    double itemPadding = 12.0;
    double itemCount = 4;
    double itemWidth = (ScreenUtils.screenWidth(context) - 30.0 - itemPadding * itemCount * 2) / itemCount;
    return Padding(
      padding: EdgeInsets.all(itemPadding),
      child: Column(
        children: [
          Consumer<AppInfo>(
            builder: (BuildContext context, AppInfo appInfo, Widget child) {
              return GestureDetector(
                onTap: () {this._handleOnTap(color, appInfo);},
                child: child,
              );
            },
            // 抽离出不会改变的部分
            child: Container(
              width: itemWidth,
              height: itemWidth,
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Color(int.parse(color)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          Text(
            title,
            style: TEXT_FONT.copyWith(
              color: Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreIcon() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(width: 3.0, color: Color(0XFFCDCDCD))
            ),
            child: GestureDetector(
              child: Icon(
                Icons.add,
                size: 60.0,
                color: Color(0XFFCDCDCD),
              ),
              onTap: () {this._handleCustomColor(context);},
            ),
          ),
          Text(
            '更多',
            style: TEXT_FONT.copyWith(
              color: Color(0XFF787878),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    List<Widget> children = [];
    themeColor.forEach((element) {
      children.add(
        this._buildItem(color: element['color'], title: element['title']),
      );
    });
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
      child: Wrap(
        children: [
          ...children,
          _buildMoreIcon(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改主题颜色'),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }
  
}