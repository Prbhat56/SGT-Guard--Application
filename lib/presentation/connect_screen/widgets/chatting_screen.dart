// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/cubit/isSelectedMedia/isSelectedMedia_cubit.dart';
import 'package:sgt/presentation/connect_screen/model/chat_messages_modal.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_bottom_sheet.dart';
import 'package:sgt/presentation/connect_screen/widgets/message_card.dart';
import 'package:sgt/presentation/connect_screen/widgets/video_sending_screen.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/service/common_service.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key, required this.user});
  final ChatUsers user;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState(user);
}

class _ChattingScreenState extends State<ChattingScreen> {
  _ChattingScreenState(this.chatUser);
  final ChatUsers chatUser;
  final ImagePicker _picker = ImagePicker();

  //pick video from carmera
  void pickVideoFromCamera() async {
    final video = await _picker.pickVideo(source: ImageSource.camera);
    video != null
        ? screenNavigator(
            context,
            VideoSendingScreen(
              file: File(video.path),
              user: widget.user,
            ))
        : null;
  }

  void pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    video != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoSendingScreen(
                file: File(video.path),
                user: widget.user,
              ),
            ),
          )
        : null;
  }

  final _userController = Get.put(ChatProfileController());
  final _myController = Get.put(ChatMessageController());

  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    Get.delete<ChatMessageController>;
    _myController.putUser(chatUser);
    Get.delete<ChatProfileController>;
    _userController.putUser(chatUser);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _myController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commonService = CommonService();
    return new MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            shadowColor: primaryColor,
            backgroundColor: white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: black,
                  size: 30,
                ),
              ),
            ),
            leadingWidth: 60,
            titleSpacing: -10,
            title: Obx(() {
              if (_userController.users.isNotEmpty) {
                return ListTile(
                  leading: Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: _userController.users.isNotEmpty
                              ? _userController.users.first.profileUrl
                              : widget.user.profileUrl.toString(),
                          fit: BoxFit.fill,
                          width: 40,
                          height: 40,
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: grey,
                              backgroundImage: NetworkImage(
                                _userController.users.isNotEmpty
                                    ? _userController.users.first.profileUrl
                                    : widget.user.profileUrl.toString(),
                              ),
                            );
                          },
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                              ),
                          errorWidget: (context, url, error) => CircleAvatar(
                                radius: 0,
                                child: Image.asset(
                                  'assets/chatProfile.png',
                                  fit: BoxFit.fill,
                                ),
                              )),
                      _userController.users.isNotEmpty
                          ? _userController.users[0].isOnline
                              ? Positioned(
                                  top: 26,
                                  left: 26,
                                  child: Container(
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      color: greenColor,
                                      border:
                                          Border.all(color: white, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                )
                              : Positioned(
                                  top: 40,
                                  left: 40,
                                  child: Container(),
                                )
                          : Positioned(
                              top: 40,
                              left: 40,
                              child: Container(),
                            )
                    ],
                  ),
                  title: Text(
                    _userController.users.isNotEmpty
                        ? _userController.users.first.name
                        : widget.user.name,
                  ),
                  subtitle: Text(_userController.users.isNotEmpty
                      ? _userController.users[0].isOnline
                          ? 'Online'
                          : MyDateUtil.getLastActiveTime(
                              context: context,
                              lastActive: _userController.users[0].lastActive)
                      : MyDateUtil.getLastActiveTime(
                          context: context,
                          lastActive: widget.user.lastActive)),
                  //  widget.user.isOnline
                  //     ? const Text("Active Now")
                  //     : const Text("Not Active"),
                );
              } else {
                return Container();
              }
            }),
            /*StreamBuilder(
                stream: FirebaseHelper.getUserInfo(widget.user),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;

                  final userList =
                      data?.map((e) => ChatUsers.fromJson(e.data())).toList() ??
                          [];

                  return ListTile(
                    leading: Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl: userList.isNotEmpty
                                ? userList.first.profileUrl
                                : widget.user.profileUrl.toString(),
                            fit: BoxFit.fill,
                            width: 40,
                            height: 40,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: 20,
                                backgroundColor: grey,
                                backgroundImage: NetworkImage(
                                  userList.isNotEmpty
                                      ? userList.first.profileUrl
                                      : widget.user.profileUrl.toString(),
                                ),
                              );
                            },
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                                ),
                            errorWidget: (context, url, error) => CircleAvatar(
                                  radius: 0,
                                  child: Image.asset(
                                    'assets/chatProfile.png',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                        userList.isNotEmpty
                            ? userList[0].isOnline
                                ? Positioned(
                                    top: 26,
                                    left: 26,
                                    child: Container(
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                        color: greenColor,
                                        border:
                                            Border.all(color: white, width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 40,
                                    left: 40,
                                    child: Container(),
                                  )
                            : Positioned(
                                top: 40,
                                left: 40,
                                child: Container(),
                              )
                      ],
                    ),
                    title: Text(
                      userList.isNotEmpty
                          ? userList.first.name
                          : widget.user.name,
                    ),
                    subtitle: Text(userList.isNotEmpty
                        ? userList[0].isOnline
                            ? 'Online'
                            : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: userList[0].lastActive)
                        : MyDateUtil.getLastActiveTime(
                            context: context,
                            lastActive: widget.user.lastActive)),
                    //  widget.user.isOnline
                    //     ? const Text("Active Now")
                    //     : const Text("Not Active"),
                  );
                }),*/
          ),
          backgroundColor: white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Obx(() {
              if (_myController.messages.isNotEmpty) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _myController.messages.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                          message:
                              _myController.messages.reversed.toList()[index]);
                    });
              } else {
                return Center(
                  child: Text(
                    'Say Hi...👋',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                );
              }
            }),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                  color: Colors.white,
                ),
                height: 60.h,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  BlocBuilder<ToggleMediaCubit, ToggleMediaState>(
                      builder: (context, state) {
                    if (state == ToggleMediaState.on) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //button to choose image from device
                          IconButton(
                            onPressed: () {
                              //showing bottom model sheet to upload image
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (BuildContext context) {
                                  return ChatBottomSheetContent(
                                    user: widget.user,
                                  );
                                },
                              );
                              context.read<ToggleMediaCubit>().toggle();
                            },
                            icon: Icon(
                              Icons.photo_rounded,
                              color: primaryColor,
                              size: 25,
                            ),
                          ),
                          //button to choose video from device
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  builder: (context) {
                                    return CustomBottomModelSheet(
                                      cameraClick: () {
                                        pickVideoFromCamera();
                                      },
                                      galleryClick: () {
                                        pickVideoFromGallery();
                                      },
                                    );
                                  });
                              context.read<ToggleMediaCubit>().toggle();
                            },
                            icon: Icon(
                              Icons.videocam_rounded,
                              color: primaryColor,
                              size: 30,
                            ),
                          )
                        ],
                      );
                    } else {
                      return IconButton(
                          onPressed: () {
                            context.read<ToggleMediaCubit>().toggle();
                          },
                          icon: Icon(
                            Icons.add_circle_sharp,
                            color: primaryColor,
                            size: 30,
                          ));
                    }
                  }),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _textEditingController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: grey,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: grey),
                        ),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: grey)),
                        hintText: 'Write a message...',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_textEditingController.text.isNotEmpty) {
                          FirebaseHelper.sendMessage(widget.user,
                                  _textEditingController.text, 'text')
                              .then((value) {
                            FirebaseHelper.updateRecentMessageTime(widget.user);
                          });
                          _textEditingController.clear();
                        } else {
                          commonService.openSnackBar(
                              "Please enter some text", context);
                        }
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: primaryColor,
                        size: 28,
                      ))
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        appBar:
            // BlocProvider.of<MessagePressedCubit>(context, listen: true)
            //         .state
            //         .messagelongpressed
            selectedChatTile.isNotEmpty
                ? AppBar(
                    elevation: 0,
                    leadingWidth: 0,
                    backgroundColor: white,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShareToConnection()));
                        },
                        icon: Icon(
                          LineIcons.upload,
                          color: black,
                          size: 30,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Delete media?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            'Are you sure you want to delete this media?',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cancel',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 70,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 1,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 65,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Delete',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 15),
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
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: black,
                            size: 25,
                          ))
                    ],
                  )
                : AppBar(
                    elevation: 0,
                    backgroundColor: white,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: black,
                          size: 30,
                        ),
                      ),
                    ),
                    leadingWidth: 25,
                    title: ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                              dummyData[widget.index].profileUrl,
                            ),
                          ),
                          dummyData[widget.index].isOnline
                              ? Positioned(
                                  top: 26,
                                  left: 26,
                                  child: Container(
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      color: greenColor,
                                      border:
                                          Border.all(color: white, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                )
                              : Positioned(
                                  top: 40,
                                  left: 40,
                                  child: Container(),
                                )
                        ],
                      ),
                      title: Text(dummyData[widget.index].name),
                      subtitle: dummyData[widget.index].isOnline
                          ? const Text("Active Now")
                          : const Text("Not Active"),
                    ),
                  ),
        backgroundColor: white,
        body: ListView(
          children: [
            ListTile(
              tileColor: selectedChatTile.contains(1) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(1);
                });
                print(selectedChatTile.contains(1));
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(1);
                });
              },
              title: SentMessageScreen(
                  message:
                      "Hey John, I need you to head over to the leasing office to check up on the back door."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(2) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(2);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(2);
                  });
                },
                title: ReceivedMessageScreen(message: "Sure!")),
            ListTile(
                tileColor: selectedChatTile.contains(3) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(3);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(3);
                  });
                },
                title: ReceivedMessageScreen(
                    message: "Should I look for something?")),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(4) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(4);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(4);
                  });
                },
                title: SentMessageScreen(message: "No we are all good")),
            ListTile(
              tileColor: selectedChatTile.contains(5) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(5);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(5);
                });
              },
              title: SentMessageScreen(
                  message:
                      "A tenant brought up a concern about a open door and there might be someone there."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(6) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(6);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(6);
                  });
                },
                title: ReceivedMessageScreen(message: "Ok I will check ")),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(7) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(7);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(7);
                });
              },
              title: SentMessageScreen(message: "Can we meet tomorrow?"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(8) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(8);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(8);
                });
              },
              title: ReceivedMessageScreen(
                  message: "Yes, of course we will meet tomorrow"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(9) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(9);
                });
              },
              onTap: () {
                selectedChatTile.contains(9)
                    ? setState(() {
                        selectedChatTile.remove(9);
                      })
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MediaPreviewScreen(index: widget.index)));
              },
              title: ImageMessage(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: selectedChatTile.contains(10) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(10);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(10);
                });
              },
              title: VideoPreviewWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 0, bottom: 15),
              child: Text(
                '10.23 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 120),
              child: ListTile(
                tileColor:
                    selectedChatTile.contains(11) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(11);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(11);
                  });
                },
                title: Stack(
                  children: [
                    Image.network(
                      'https://images.pexels.com/photos/5702958/pexels-photo-5702958.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      height: 150,
                    ),
                    Positioned(
                      top: 250,
                      child: Center(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Container(
                              child: Text(''),
                            )),
                      ),
                    ),
                    Positioned(
                        top: 60,
                        left: 70,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download_outlined,
                                  color: white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Retry',
                                  style: TextStyle(color: white),
                                ),
                              ],
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5, bottom: 15),
              child: Row(
                children: [
                  Text(
                    '10.30 A.M.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(Icons.av_timer, size: 17.sp, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: selectedChatTile.contains(7) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(7);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(7);
                });
              },
              title: SentMessageScreen(
                  message:
                      "A tenant brought up a concern about a open door and there might be someone there."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Row(
                children: [
                  Text(
                    '10.30 A.M.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(Icons.av_timer, size: 17.sp, color: Colors.grey),
                ],
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(9) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(9);
                });
              },
              onTap: () {
                selectedChatTile.contains(9)
                    ? setState(() {
                        selectedChatTile.remove(9);
                      })
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MediaPreviewScreen(index: widget.index)));
              },
              title: ImageMessage(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.grey),
              ),
              color: Colors.white,
            ),
            height: 60,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              selectMedia
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //button to choose image from device
                        IconButton(
                          onPressed: () {
                            //showing bottom model sheet to upload image
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) {
                                  return CustomBottomModelSheet(
                                    cameraClick: () {
                                      pickCameraImage();
                                    },
                                    galleryClick: () {
                                      pickGalleryImage();
                                    },
                                  );
                                });
                            // showModalBottomSheet(
                            //     context: context,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(20)),
                            //     builder: (context) {
                            //       return Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 8, vertical: 25),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             const Text(
                            //               'Select Media From?',
                            //               style: TextStyle(fontSize: 16),
                            //             ),
                            //             const Text(
                            //               'Use camera or select file from device gallery',
                            //               style: TextStyle(
                            //                   fontSize: 12,
                            //                   color: Color.fromARGB(
                            //                       255, 109, 109, 109)),
                            //             ),
                            //             const SizedBox(
                            //               height: 20,
                            //             ),
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceAround,
                            //               children: [
                            //                 InkWell(
                            //                   onTap: () async {
                            //                     // Capture a photo
                            //                     final XFile? photo =
                            //                         await _picker.pickImage(
                            //                             source:
                            //                                 ImageSource.camera);
                            //                     photo != null
                            //                         ? Navigator.push(
                            //                             context,
                            //                             MaterialPageRoute(
                            //                               builder: (context) =>
                            //                                   ImageSendingScreen(
                            //                                 file: File(
                            //                                     photo.path),
                            //                               ),
                            //                             ),
                            //                           )
                            //                         : null;
                            //                   },
                            //                   child: Column(
                            //                     children: [
                            //                       Container(
                            //                         height: 60,
                            //                         width: 60,
                            //                         decoration: BoxDecoration(
                            //                           color: grey,
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   10),
                            //                         ),
                            //                         child: const Icon(
                            //                           Icons.camera_alt,
                            //                           size: 30,
                            //                         ),
                            //                       ),
                            //                       const SizedBox(
                            //                         height: 8,
                            //                       ),
                            //                       const Text('Camera')
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 InkWell(
                            //                   onTap: () async {
                            //                     // Pick multiple images
                            //                     final List<XFile>? images =
                            //                         await _picker
                            //                             .pickMultiImage();
                            //                     images != null
                            //                         ? Navigator.push(
                            //                             context,
                            //                             MaterialPageRoute(
                            //                               builder: (context) =>
                            //                                   ImageSendingScreen(
                            //                                 file: File(
                            //                                     images[0].path),
                            //                               ),
                            //                             ),
                            //                           )
                            //                         : null;
                            //                   },
                            //                   child: Column(
                            //                     children: [
                            //                       Container(
                            //                         height: 60,
                            //                         width: 60,
                            //                         decoration: BoxDecoration(
                            //                           color: white,
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   10),
                            //                           boxShadow: [
                            //                             BoxShadow(
                            //                               color: Colors.grey
                            //                                   .withOpacity(0.5),
                            //                               spreadRadius: 5,
                            //                               blurRadius: 7,
                            //                               offset: const Offset(
                            //                                 0,
                            //                                 3,
                            //                               ), // changes position of shadow
                            //                             ),
                            //                           ],
                            //                         ),
                            //                         child: const Icon(
                            //                           Icons.photo_outlined,
                            //                           size: 30,
                            //                         ),
                            //                       ),
                            //                       const SizedBox(
                            //                         height: 8,
                            //                       ),
                            //                       const Text('Gallery')
                            //                     ],
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     });

                            setState(() {
                              selectMedia = false;
                            });
                          },
                          icon: Icon(
                            Icons.photo_rounded,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                        //button to choose video from device
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) {
                                  return CustomBottomModelSheet(
                                    cameraClick: () {
                                      pickVideoFromCamera();
                                    },
                                    galleryClick: () {
                                      pickVideoFromGallery();
                                    },
                                  );
                                });
                            setState(() {
                              selectMedia = false;
                            });
                          },
                          icon: Icon(
                            Icons.videocam_rounded,
                            color: primaryColor,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          selectMedia = true;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_sharp,
                        color: primaryColor,
                        size: 30,
                      )),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: grey,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: grey),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: grey)),
                    hintText: 'Write a message',
                  ),
                  onTap: () {
                    setState(() {
                      selectMedia = false;
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_rounded,
                    color: primaryColor,
                    size: 35,
                  ))
            ]),
          ),
        ),
      ),
    );
  }*/
}
