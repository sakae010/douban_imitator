import 'dart:async';

import 'package:douban_imitator/constant/constant.dart';
import 'package:douban_imitator/pages/container_page.dart';
import 'package:douban_imitator/utils/screen_utils.dart';
import 'package:flutter/material.dart';

/// 打开App首页
class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  var container = const ContainerPage();

  bool showAd = true;

  @override
  Widget build(BuildContext context) {
    print("build splash");
    return Stack(
      children: [
        /// 通过offsatge字段控制child是否显示
        /// offstage并不是通过插入或者删除widget tree的节点来实现显示隐藏效果,
        /// 而是通过自身尺寸,不响应hitTest以及不绘制,来达到展示与隐藏的效果;
        Offstage(
          child: container,
          offstage: showAd,
        ),
        Offstage(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            const AssetImage(Constant.imagePrefix + 'home.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "落花有意随流水，流水无心恋落花",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: const Alignment(1.0, 0.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        child: CountDownWidget(
                          onCountDownFinishCallback: (bool value) {
                            if (value) {
                              setState(() {
                                showAd = false;
                              });
                            }
                          },
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Constant.imagePrefix + 'ic_launcher.png',
                              width: 50.0, height: 50.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Hi，豆芽",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
          ),
          offstage: !showAd,
        )
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final ValueChanged<bool> onCountDownFinishCallback;

  const CountDownWidget({Key? key, required this.onCountDownFinishCallback})
      : super(key: key);

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  int _seconds = 6;
  Timer? _timer;

  @override
  void initState() {
    _startTime();
    super.initState();
  }

  /// 启动倒计时的计时器。
  void _startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_seconds <= 1) {
        widget.onCountDownFinishCallback(true);
        _cancelTimer();
        return;
      }
      //更新界面
      setState(() {
        _seconds--;
      });
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: const TextStyle(fontSize: 17.0),
    );
  }
}
