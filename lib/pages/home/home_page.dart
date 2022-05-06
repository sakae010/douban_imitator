import 'package:douban_imitator/constant/constant.dart';
import 'package:douban_imitator/http/API.dart';
import 'package:douban_imitator/http/mock_request.dart';
import 'package:douban_imitator/model/subject.dart';
import 'package:douban_imitator/widgets/search_text_field_widget.dart';
import 'package:douban_imitator/pages/home/home_app_bar.dart' as my_app_bar;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('build HomePage');
    }
    return getWidget();
  }
}

var _tabs = ['动态', '推荐'];

DefaultTabController getWidget() {
  return DefaultTabController(
      initialIndex: 1,
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: my_app_bar.SliverAppBar(
                pinned: true,
                expandedHeight: 120.0,
                primary: true,
                titleSpacing: 0.0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.green,
                    child: SearchTextFieldWidget(
                      hintText: "影视作品中你难忘的离别",
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      onTap: () {},
                    ),
                    alignment: const Alignment(0.0, 0.0),
                  ),
                ),
                bottomTextString: _tabs,
                bottom: TabBar(
                  tabs: _tabs.map((String name) {
                    return Container(
                      child: Text(name),
                      padding: const EdgeInsets.only(bottom: 5.0),
                    );
                  }).toList(),
                ),
              ),
            )
          ];
        },
        body: TabBarView(
            children: _tabs.map((String name) {
          return SliverContainer(name: name);
        }).toList()),
      ));
}

class SliverContainer extends StatefulWidget {
  final String name;

  const SliverContainer({Key? key, required this.name}) : super(key: key);

  @override
  State<SliverContainer> createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  List<Subject>? list;

  @override
  void initState() {
    if (kDebugMode) {
      print('init state${widget.name}');
    }

    ///请求动态数据
    if (list == null) {
      if (_tabs[0] == widget.name) {
        requestAPI();
      } else {
        ///请求推荐数据
        requestAPI();
      }
    }
    super.initState();
  }

  void requestAPI() async {
    MockRequest _request = MockRequest();
    dynamic result = await _request.get(API.TOP_250);
    dynamic resultList = result["subjects"];
    list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {
      list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget getContentSliver(BuildContext context, List<Subject> list) {
    if (widget.name == _tabs[0]) {
      return _loginContainer(context);
    }

    if (list.isEmpty) {
      return const Text('暂无数据');
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            key: PageStorageKey<String>(widget.name),
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return getCommonItem(list, index);
              }, childCount: list.length))
            ],
          );
        },
      ),
    );
  }

  ///列表的普通单个item
  getCommonItem(List<Subject> items, int index) {}
}

/// 动态TAB
_loginContainer(BuildContext context) {
  return Align(
    alignment: const Alignment(0.0, 0.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Constant.imagePrefix + "ic_new_empty_view_default.png",
          width: 120.0,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
          child: Text(
            "登录后查看关注人动态",
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        GestureDetector(
          child: Container(
            child: const Text(
              "去登录",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
            padding: const EdgeInsets.only(
                left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: const BorderRadius.all(Radius.circular(6.0))),
          ),
          onTap: () {},
        )
      ],
    ),
  );
}
