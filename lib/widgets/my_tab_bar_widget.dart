import 'package:douban_imitator/pages/douya_top_250_list_widget.dart';
import 'package:douban_imitator/pages/movie/movie_page.dart';
import 'package:flutter/material.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  const FlutterTabBarView({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build FlutterTabBarView');
    List<Widget> viewList = [
      const MoviePage(
        key: PageStorageKey<String>('MoviePage'),
      ),
      const Page2(),
      const DouBanListView(
        key: PageStorageKey<String>('DouBanListView'),
      ),
      const Page4(),
      const Page5(),
      const Page1(),
    ];
    return TabBarView(children: viewList, controller: tabController);
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Page1');

    return const Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Page2');
    return const Center(
      child: Text('Page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Page3');
    return const Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Page4');
    return const Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Page5');
    return const Center(
      child: Text('Page5'),
    );
  }
}
