import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/constants/contants.dart';
import 'package:time_manager/style/font.dart';
import 'package:time_manager/utils/screen_utils.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final String imgUrl;

  EmptyWidget({ this.message = '', this.imgUrl = '${Constants.IMAGE_PATH}/empty.png' });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(this.imgUrl),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(this.message, style: EMPTY_FONT),
          ),
        ],
      ),
    );
  }
}