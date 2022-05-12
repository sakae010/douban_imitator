import 'package:douban_imitator/constant/constant.dart';
import 'package:flutter/foundation.dart';
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

  late VoidCallback listener;

  bool _showSeekBar = true;

  @override
  void initState() {
    super.initState();

    print('播放${widget.url}');
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        if (mounted) {
          //初始化完成后，更新状态
          setState(() {});
          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(const Duration(seconds: 0));
            setState(() {});
          }
        }
      });

    listener = () {
      if (mounted) {
        setState(() {});
      }
    };

    _controller.addListener(listener);
  }

  /// 主widget被删除时回调
  @override
  void deactivate() {
    _controller.removeListener(listener);

    super.deactivate();
  }

  /// 主widget被永久删除时回调
  @override
  void dispose() {
    //释放播放器资源
    _controller.dispose();

    super.dispose();
  }

  ///更新播放的URL
  void setUrl(String url) {
    if (mounted) {
      if (kDebugMode) {
        print('updateUrl');
      }
    }
    _controller.removeListener(listener);
    _controller.pause();

    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        if (mounted) {
          //初始化完成后，更新状态
          setState(() {});
          if (_controller.value.duration == _controller.value.position) {
            _controller.seekTo(const Duration(seconds: 0));
            setState(() {});
          }
        }
      });

    listener = () {
      if (mounted) {
        setState(() {});
      }
    };

    _controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          setState(() {
            _showSeekBar = !_showSeekBar;
          });
        },
      ),
      getPlayController()
    ];

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        /// StackFit.loose 按最小的来.
        // StackFit.expand 按最大的来.
        // StackFit.passthrough Stack上层为->Expanded->Row, 横向尽量大, 纵向尽量小.
        fit: StackFit.passthrough,
        children: children,
      ),
    );
  }

  getPlayController() {
    return Offstage(
      offstage: !_showSeekBar,
      child: Stack(
        children: [
          Align(
            child: IconButton(
              iconSize: 55.0,
              icon: Image.asset(Constant.imagePrefix +
                  (_controller.value.isPlaying
                      ? 'ic_pause.png'
                      : 'ic_playing.png')),
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
            ),
            alignment: Alignment.center,
          ),
          getProgressContent(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
              child: _controller.value.isBuffering
                  ? const CircularProgressIndicator()
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Widget getProgressContent() {
    return (widget.showProgressBar || widget.showProgressText)
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 13.0,
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Offstage(
                    offstage: !widget.showProgressBar,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                          playedColor: Colors.amberAccent,
                          backgroundColor: Colors.grey),
                    ),
                  ),
                )),
                Offstage(
                  offstage: !widget.showProgressText,
                  child: getDurationText(),
                )
              ],
            ),
          )
        : Container();
  }

  Text getDurationText() {
    String txt;
    if (_controller.value.position == null ||
        _controller.value.duration == null) {
      txt = '00:00/00:00';
    } else {
      txt =
          '${getMinuteSeconds(_controller.value.position.inSeconds)}/${getMinuteSeconds(_controller.value.duration.inSeconds)}';
    }
    return Text(
      txt,
      style: const TextStyle(color: Colors.white, fontSize: 14.0),
    );
  }

  String getMinuteSeconds(int inSeconds) {
    if (inSeconds == null || inSeconds <= 0) {
      return '00:00';
    }
    int tmp = inSeconds ~/ Duration.secondsPerMinute;
    String minute;
    if (tmp < 10) {
      minute = '0$tmp';
    } else {
      minute = '$tmp';
    }

    int tmp1 = inSeconds % Duration.secondsPerMinute;
    String seconds;
    if (tmp1 < 10) {
      seconds = '0$tmp1';
    } else {
      seconds = '$tmp1';
    }
    return '$minute:$seconds';
  }
}
