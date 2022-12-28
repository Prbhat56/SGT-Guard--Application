import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_widget.dart';

class VideoSendingScreen extends StatefulWidget {
  const VideoSendingScreen({
    super.key,
    required this.file,
  });

  final File file;
  @override
  State<VideoSendingScreen> createState() => _VideoSendingScreenState();
}

class _VideoSendingScreenState extends State<VideoSendingScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.file);
    _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 4.5 / 5,
              child: VideoWidget(
                file: widget.file,
              ),
            ),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 20),
                  hintText: 'Daniel Santio',
                  hintStyle: TextStyle(color: Colors.white),
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusColor: Colors.white,
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      )),
    );
  }
}
