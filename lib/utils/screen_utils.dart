
import 'package:flutter/material.dart';

class ScreenUtils {

  /// 当前屏幕宽度
  static double screenW(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  /// 当前屏幕高度
  static double screenH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }
}