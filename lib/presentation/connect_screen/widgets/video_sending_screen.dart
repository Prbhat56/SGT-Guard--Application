import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:video_player/video_player.dart';
import 'video_widget.dart';

class VideoSendingScreen extends StatefulWidget {
  const VideoSendingScreen({
    super.key,
    required this.file,
    required this.user,
  });

  final File file;
  final ChatUsers user;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1 / 1.3,
              width: MediaQuery.of(context).size.width,
              child: VideoWidget(
                file: widget.file,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                readOnly: true,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    hintText: widget.user.name,
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusColor: Colors.white,
                    suffixIcon: IconButton(
                        onPressed: () {
                          EasyLoading.show();
                          FirebaseHelper.uplodVideo(
                                  widget.user, widget.file.path)
                              .then((value) {
                            FirebaseHelper.updateRecentMessageTime(widget.user);
                            setState(() {
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          });
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
