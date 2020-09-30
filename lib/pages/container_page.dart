import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_manager/constants/navigator.dart';
import 'package:time_manager/pages/done_list_page.dart';
import 'package:time_manager/pages/home_page.dart';
import 'package:time_manager/style/font.dart';

/// the container of the whole app, including bottom tab bar
class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}): super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  /// 当前选中的页面
  int _selectedIndex = 0;
  List<Widget> pages;
  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    /// 初始化状态：导航栏和页面的列表
    if (pages == null) {
      pages = [
        HomePage(),
        DoneListPage(),
      ];
    }
    if (itemList == null) {
      itemList = BOTTOM_NAVIGATOR_ITEM_LIST.map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon),
        title: Text(item.title, style: BOTTOM_NAVIGATOR_FONT),
      )).toList();
    }
  }

  /// stage state when changes bottom navigator
  // _getPageWidget(index) {
  //   return Offstage(
  //     offstage: _selectedIndex != index,
  //     child: pages[index],
  //   );
  // }
  
  /// 点击导航栏按钮改变当前页面
  handleChangePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// stage state when changes bottom navigator
      // body: Stack(
      //   children: [
      //     _getPageWidget(0),
      //     _getPageWidget(1),
      //   ],
      // ),
      body: pages[_selectedIndex],
      /// 屏幕下方导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: handleChangePage,
        currentIndex: _selectedIndex,
        // fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}