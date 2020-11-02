import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/pages/theme_setting_page.dart';
import 'package:time_manager/style/font.dart';
import 'package:time_manager/utils/global.dart';
import 'package:time_manager/widgets/press_check_widget.dart';
import 'package:time_manager/widgets/press_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  Widget _buildTextItem(String text) {
    return _buildItemContainer(
      child: PressWidget(
        child: Text(text, style: TEXT_FONT),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        onTap: () {
           Navigator.push(context, MaterialPageRoute(
            builder: (context) => ThemeSettingPage(),
          ));
        },
      ),
    );
  }

  handleChangeDoubleCheck() {
    Global.changeIsDoubleCheck(!Global.isDoubleCheck);
    this.setState(() {});
  }

  Widget _buildCheckItem({@required bool isCheck}) {
    return PressCheckWidget(
      isCheck: Global.isDoubleCheck,
      child: Text('删除时是否二次确认？', style: TEXT_FONT),
      handlePressCheck: this.handleChangeDoubleCheck,
    );
  }

  Widget _buildItemContainer({ @required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设定'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          this._buildTextItem('修改主题颜色'),
          this._buildCheckItem(isCheck: true),
          Divider(
            color: Color(0xffefefef),
            thickness: 2.0,
            height: 24.0,
          ),
        ],
      ),
    );
  }
}