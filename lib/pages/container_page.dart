import 'package:douban_imitator/constant/constant.dart';
import 'package:douban_imitator/pages/group/group_page.dart';
import 'package:douban_imitator/pages/home/home_page.dart';
import 'package:douban_imitator/pages/movie/book_audio_video_page.dart';
import 'package:douban_imitator/pages/person/person_center_page.dart';
import 'package:douban_imitator/pages/shop_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///这个页面是作为整个APP的最外层的容器，以Tab为基础控制每个item的显示与隐藏
class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _selectIndex = 0;

  final ShopPageWidget shopPageWidget = const ShopPageWidget();

  List<Widget>? pages;

  List<BottomNavigationBarItem>? itemList;

  final itemNames = [
    _Item(
        name: "首页",
        activeIcon: "${Constant.imagePrefix}ic_tab_home_active.png",
        normalIcon: "${Constant.imagePrefix}ic_tab_home_normal.png"),
    _Item(
        name: "书影音",
        activeIcon: "${Constant.imagePrefix}ic_tab_subject_active.png",
        normalIcon: "${Constant.imagePrefix}ic_tab_subject_normal.png"),
    _Item(
        name: "小组",
        activeIcon: "${Constant.imagePrefix}ic_tab_group_active.png",
        normalIcon: "${Constant.imagePrefix}ic_tab_group_normal.png"),
    _Item(
        name: "市集",
        activeIcon: "${Constant.imagePrefix}ic_tab_shiji_active.png",
        normalIcon: "${Constant.imagePrefix}ic_tab_shiji_normal.png"),
    _Item(
        name: "我的",
        activeIcon: "${Constant.imagePrefix}ic_tab_profile_active.png",
        normalIcon: "${Constant.imagePrefix}ic_tab_profile_normal.png"),
  ];

  @override
  void initState() {
    if (kDebugMode) {
      print('initState _ContainerPageState');
    }
    pages ??= [
      const HomePage(),
      const BookAudioVideoPage(),
      const GroupPage(),
      shopPageWidget,
      const PersonCenterPage()
    ];
    itemList ??= itemNames
        .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              activeIcon: Image.asset(
                item.activeIcon,
                width: 30.0,
                height: 30.0,
              ),
              label: item.name,
            ))
        .toList();
    super.initState();
  }

  //Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      /// TickerMode 组件可以禁用/启用子树下所有的 Ticker
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages![index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build _ContainerPageState');
    return Scaffold(
      body: Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList!,
        onTap: (int index) {
          ///这里根据点击的index来显示，非index的page均隐藏
          setState(() {
            _selectIndex = index;
          });
        },
        // 当前选中索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)
        // （仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: const Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _Item {
  String name;
  String activeIcon;
  String normalIcon;

  _Item(
      {required this.name, required this.activeIcon, required this.normalIcon});
}
