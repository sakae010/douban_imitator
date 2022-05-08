import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final String? previewImgUrl; //预览图片的地址
  final bool showProgressBar; //是否显示进度条
  final bool showProgressText; //是否显示进度文本

  const VideoWidget(this.url,
      {Key? key,
      this.previewImgUrl,
      this.showProgressBar = true,
      this.showProgressText = true})
      : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  late VideoPlayerController _controller;

  VoidCallback? listener;

  bool _showSeekBar = true;

  @override
  void initState() {
    super.initState();
    print('播放${widget.url}');
    _controller = VideoPlayerController.network(widget.url)
    ..initialize().then((value) => {
      if (mounted) {
        //初始化完成后，更新状态
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    //释放播放器资源
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
