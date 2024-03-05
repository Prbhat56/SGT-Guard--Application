import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/utils/const.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatefulWidget {
  const VideoPreviewWidget({super.key, required this.vdoUrl});
  final String vdoUrl;

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.vdoUrl));

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.7,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FullScreenVideo(widget.vdoUrl.toString())),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    Positioned(
                      top: 50,
                      left: 120,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // VideoProgressIndicator(
                    //   _controller,
                    //   allowScrubbing: true,
                    //   colors: VideoProgressColors(
                    //       backgroundColor: Colors.red,
                    //       bufferedColor: Colors.black,
                    //       playedColor: Colors.blueAccent),
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class FullScreenVideo extends StatefulWidget {
  const FullScreenVideo(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    // controller.initialize().then((_) => setState(() {}));
    _initializeVideoPlayerFuture = controller.initialize();
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: ""),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.zero,
                  colors: VideoProgressColors(
                    backgroundColor: Color(0xFF243771),
                    playedColor: primaryColor,
                    bufferedColor: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      },
                      child: ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: controller,
                        builder: (_, _videoPlayerValue, __) {
                          return Icon(
                            _videoPlayerValue.isPlaying
                                ? Icons.pause_circle_outline_rounded
                                : Icons.play_circle_outline_rounded,
                            size: 30,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        controller.seekTo(Duration(seconds: 0));
                        controller.pause();
                      },
                      child: Icon(
                        Icons.stop_circle_outlined,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 10),
                    // render duration video with current position / total video duration
                    ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: controller,
                      builder: (_, _videoPlayerValue, __) {
                        return Text(
                          "00:${_videoPlayerValue.position.inSeconds.toString().padLeft(2, '0')}",
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                    Text(
                      " / 00:${controller.value.duration.inSeconds.toString()}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    //render Volume button
                    InkWell(
                      onTap: () {
                        if (controller.value.volume == 0.0) {
                          controller.setVolume(1.0);
                        } else
                          controller.setVolume(0.0);
                      },
                      child: ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: controller,
                        builder: (_, _videoPlayerValue, __) {
                          return Icon(
                            _videoPlayerValue.volume == 0.0
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            size: 30,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        },
      ),
      /*Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: VideoPlayer(controller),
          ),
        ),
      ),*/
    );
  }
}
