import 'package:flutter/material.dart';

class RadiusImg {
  static Widget get(String imgUrl,
      {double? imgW,
      double? imgH,
      Color? shadowColor,
      double? elevation,
      double radius = 6.0,
      RoundedRectangleBorder? shape}) {
    shadowColor ??= Colors.transparent;

    return Card(
      // 影音海报
      shape: shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
      color: shadowColor,

      /// Clip.none：不做处理
      // Clip.hardEdge：裁剪但不应用抗锯齿，速度比none慢一点
      // Clip.antiAlias：裁剪而且抗锯齿，速度慢于hardEdge
      // Clip.antiAliasWithSaveLayer：裁剪、抗锯齿而且有一个缓冲区，速度最慢
      clipBehavior: Clip.antiAlias,
      elevation: elevation == null ? 0.0 : 5.0,
      child: imgW == null
          ? Image.network(imgUrl, height: imgH, fit: BoxFit.cover)
          : Image.network(
              imgUrl,
              width: imgW,
              height: imgH,
              fit: imgH == null ? BoxFit.contain : BoxFit.cover,
            ),
    );
  }
}
