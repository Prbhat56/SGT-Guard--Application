import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class PropertyVideoPreviewWidget extends StatefulWidget {
  const PropertyVideoPreviewWidget({super.key});

  @override
  State<PropertyVideoPreviewWidget> createState() =>
      _PropertyVideoPreviewWidgetState();
}

class _PropertyVideoPreviewWidgetState
    extends State<PropertyVideoPreviewWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

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
    return Padding(
      padding: _controller.value.isPlaying
          ? EdgeInsets.all(0)
          : EdgeInsets.only(top: 215.h),
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Positioned(
                  top: 90,
                  left: 150,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: _controller.value.isPlaying
                        ? Container()
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                _controller.value.isPlaying
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, top: 180.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  width: 20,
                                  child: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                      backgroundColor: Colors.red,
                                      bufferedColor: Colors.black,
                                      playedColor: Colors.blueAccent),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
