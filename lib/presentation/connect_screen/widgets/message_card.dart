import 'dart:io';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_messages_modal.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/connect_screen/widgets/custom_shape.dart';
import 'package:sgt/presentation/connect_screen/widgets/video_preview.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:dio/dio.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message, required this.user});
  final ChatMessages message;
  final ChatUsers user;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  var commonService = CommonService();

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseHelper.user.uid == widget.message.fromId;

    return InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _sendMessage() : _receivedMessage());
  }

  Widget _sendMessage() {
    final messageTextGroup = Flexible(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.all(widget.message.type == "text" ? 14 : 8),
                    decoration: BoxDecoration(
                      color: widget.message.type == "text"
                          ? primaryColor
                          : seconderyColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                        bottomLeft: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                        bottomRight: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                      ),
                    ),
                    child: Builder(builder: (context) {
                      if (widget.message.type == "text") {
                        return Text(
                          widget.message.message,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        );
                      } else if (widget.message.type == "photo") {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenImageViewer(
                                      widget.message.message.toString())),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                                imageUrl: widget.message.message.toString(),
                                fit: BoxFit.contain,
                                height: 150,
                                width: 150,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                      strokeCap: StrokeCap.round,
                                    ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/sgt_logo.jpg',
                                      fit: BoxFit.fill,
                                    )),
                          ),
                        );
                      } else if (widget.message.type == "video") {
                        return Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: VideoPreviewWidget(
                            vdoUrl: widget.message.message.toString(),
                          ),
                        );
                      } else {
                        return Text(
                          widget.message.message,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        );
                      }
                    }),
                  ),
                ),
                CustomPaint(
                    painter: CustomShape(
                  widget.message.type == "text" ? primaryColor : seconderyColor,
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    // MyDateUtil.getFormattedTime(
                    //     context: context, time: widget.message.sent),
                    MyDateUtil.getChatMsgTime(
                        context: context, lastActive: widget.message.sent),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  widget.message.read.isNotEmpty
                      ? Icon(
                          Icons.done_all_rounded,
                          color: primaryColor,
                          size: 16,
                        )
                      : Icon(
                          Icons.done_all_rounded,
                          color: Colors.grey,
                          size: 16,
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          messageTextGroup,
        ],
      ),
    );
  }

  Widget _receivedMessage() {
    if (widget.message.read.isEmpty) {
      FirebaseHelper.updateMessageReadStatus(widget.message, widget.user);
    }
    final messageTextGroup = Flexible(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: CustomPaint(
                    painter: CustomShape(Colors.grey[300]!),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.all(widget.message.type == "text" ? 14 : 8),
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                        bottomLeft: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                        bottomRight: Radius.circular(
                            widget.message.type == "text" ? 18 : 8),
                      ),
                    ),
                    child: Builder(builder: (context) {
                      if (widget.message.type == "text") {
                        return Text(
                          widget.message.message,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        );
                      } else if (widget.message.type == "photo") {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenImageViewer(
                                      widget.message.message.toString())),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                                imageUrl: widget.message.message.toString(),
                                fit: BoxFit.contain,
                                height: 150,
                                width: 150,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                      strokeCap: StrokeCap.round,
                                    ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/sgt_logo.jpg',
                                      fit: BoxFit.fill,
                                    )),
                          ),
                        );
                      } else if (widget.message.type == "video") {
                        return Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: VideoPreviewWidget(
                            vdoUrl: widget.message.message.toString(),
                          ),
                        );
                      } else {
                        return Text(
                          widget.message.message,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    // MyDateUtil.getFormattedTime(
                    //     context: context, time: widget.message.sent),
                    MyDateUtil.getChatMsgTime(
                        context: context, lastActive: widget.message.sent),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          messageTextGroup,
        ],
      ),
    );
  }

  void _showBottomSheet(bool isMe) {
    var mq = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              widget.message.type == 'text'
                  ?
                  //copy option
                  _OptionItem(
                      icon: Icon(Icons.copy_all_rounded,
                          color: primaryColor, size: 26),
                      name: 'Copy Text',
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.message))
                            .then((value) {
                          //for hiding bottom sheet
                          Navigator.pop(context);

                          MyDateUtil.showSnackbar(context, 'Text Copied!');
                        });
                      })
                  :
                  //save option
                  _OptionItem(
                      icon: Icon(Icons.download_rounded,
                          color: primaryColor, size: 26),
                      name: widget.message.type == 'photo'
                          ? 'Save Image'
                          : 'Save Video',
                      onTap: () async {
                        print('Image Url: ${widget.message.message}');

                        if (widget.message.type == 'photo') {
                          try {
                            final path = '${Directory.systemTemp.path}/SGT.jpg';
                            await Dio().download(
                              widget.message.message,
                              path,
                            );
                            await Gal.putImage(path, album: 'SGT')
                                .then((success) {
                              //for hiding bottom sheet
                              Navigator.pop(context);
                              MyDateUtil.showSnackbar(
                                  context, 'Image Successfully Saved!');
                            });
                          } catch (e) {
                            print('ErrorWhileSavingMedia: $e');
                          }
                        } else {
                          try {
                            EasyLoading.show();
                            final path = '${Directory.systemTemp.path}/SGT.mp4';
                            await Dio().download(
                              widget.message.message,
                              path,
                            );
                            await Gal.putVideo(path, album: 'SGT')
                                .then((success) {
                              //for hiding bottom sheet
                              Navigator.pop(context);
                              EasyLoading.dismiss();
                              MyDateUtil.showSnackbar(
                                  context, 'Video Successfully Saved!');
                            });
                          } catch (e) {
                            EasyLoading.dismiss();
                            print('ErrorWhileSavingMedia: $e');
                          }
                        }
                      }),

              //separator or divider
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

              //edit option
              if (widget.message.type == 'text' && isMe)
                _OptionItem(
                    icon: Icon(Icons.edit, color: primaryColor, size: 26),
                    name: 'Edit Message',
                    onTap: () {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      _showMessageUpdateDialog();
                    }),

              //delete option
              if (isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () {
                      Navigator.pop(context);
                      _showDeleteDialogue();
                    }),

              //separator or divider
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

              //sent time
              _OptionItem(
                  icon: Icon(Icons.remove_red_eye, color: primaryColor),
                  name:
                      'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent)}',
                  onTap: () {}),

              //read time
              _OptionItem(
                  icon: Icon(Icons.remove_red_eye, color: greenColor),
                  name: widget.message.read.isEmpty
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.read)}',
                  onTap: () {}),
            ],
          );
        });
  }

  void _showDeleteDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Delete message?',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Are you sure you want to delete this message?',
                    textAlign: TextAlign.center,
                    // ignore: deprecated_member_use
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: CustomTheme.white,
                          border: Border.all(color: CustomTheme.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              //hide alert dialog
                              Navigator.pop(context);
                            },
                            child: Text(
                              'cancel'.tr,
                              // ignore: deprecated_member_use
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: CustomTheme.primaryColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          border: Border.all(color: CustomTheme.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseHelper.deleteMessage(widget.message)
                                .then((value) {
                              //for hiding bottom sheet
                              Navigator.pop(context);
                            });
                          },
                          child: Center(
                            child: Text(
                              'Delete',
                              // ignore: deprecated_member_use
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: CustomTheme.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.message;
    ScrollController _scrollController = ScrollController();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 10),

              //content
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Edit Message',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: TextFormField(
                      scrollController: _scrollController,
                      //autofocus: true,
                      initialValue: updatedMsg,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      autocorrect: true,
                      onChanged: (value) => updatedMsg = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: CustomTheme.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: CustomTheme.white,
                            border: Border.all(color: CustomTheme.primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (context.mounted) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                'cancel'.tr,
                                // ignore: deprecated_member_use
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: CustomTheme.primaryColor,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 50,
                        // ),
                        Container(
                          height: 40,
                          width: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        // SizedBox(
                        //   width: 50,
                        // ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: CustomTheme.primaryColor,
                            border: Border.all(color: CustomTheme.primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                FirebaseHelper.updateMessage(
                                    widget.message, updatedMsg);
                                if (context.mounted) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                'Update',
                                // ignore: deprecated_member_use
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: CustomTheme.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: ""),
      body: InteractiveViewer(
        panEnabled: true, // Set it to false
        //boundaryMargin: EdgeInsets.all(10),
        minScale: 0.5,
        maxScale: 2,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ),
            transitionOnUserGestures: true,
          ),
        ),
      ),
    );
  }
}
