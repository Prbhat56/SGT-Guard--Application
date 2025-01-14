import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.file});
  final File file;
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  bool _muted = false;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.file);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 2.5,
                left: MediaQuery.of(context).size.width * 1 / 2.5,
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
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
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _muted = !_muted;
                      _controller.setVolume(_muted ? 0 : 1);
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: _muted
                          ? Icon(
                              Icons.volume_off_rounded,
                              size: 30,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.volume_up_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 30,
                child: _controller.value.isInitialized
                    ? Container(
                        height: 40,
                        // width: 70,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "00:${_controller.value.duration.inSeconds.toString()}",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Positioned(
                left: 150,
                top: 30,
                child: _controller.value.isInitialized
                    ? Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "${getFileSize(File(widget.file.path)).toStringAsFixed(2)}",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Text(
                                "MB",
                                //softWrap: true,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
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
