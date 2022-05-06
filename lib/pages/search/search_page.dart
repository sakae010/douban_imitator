import 'package:flutter/material.dart';

/// 搜索
class SearchPage extends StatefulWidget {
  ///搜索框中的默认显示内容
  final String searchHintContent;

  const SearchPage({Key? key, this.searchHintContent = '用一部电影来形容你的2018'})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
