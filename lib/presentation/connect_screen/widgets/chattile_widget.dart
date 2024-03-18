// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_messages_modal.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/connect_screen/widgets/profile_image.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../cubit/islongpressed/islongpress_cubit.dart';
import 'chat_model.dart';
import 'chatting_screen.dart';

/*
class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget(
      {Key? key, required this.index, required this.color, required this.cubit})
      : super(key: key);
  final int index;
  final Color color;
  final IslongpressCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          selectedColor: color,
          tileColor: color,
          onLongPress: () {
            cubit.state.selectedChatTile.contains(index)
                ? null
                : BlocProvider.of<IslongpressCubit>(context).addtoList(index);
          },
          onTap: () {
            cubit.state.selectedChatTile.contains(index)
                ? cubit.removefromList(index)
                : Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChattingScreen(
                        index: index,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1, 0), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
          },
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: grey,
                backgroundImage: NetworkImage(
                  dummyData[index].profileUrl,
                ),
              ),
              dummyData[index].isOnline
                  ? Positioned(
                      top: 40,
                      left: 40,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: greenColor,
                          border: Border.all(color: white, width: 2),
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
          title: Text(dummyData[index].name),
          subtitle: dummyData[index].isSendByMe
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    dummyData[index].messagetype == 'not_send'
                        ? Icon(
                            Icons.av_timer,
                            size: 17.sp,
                          )
                        : Icon(
                            Icons.done_all_outlined,
                            size: 17.sp,
                            color: dummyData[index].ismessageSeen
                                ? primaryColor
                                : Colors.grey,
                          ),
                    dummyData[index].messagetype == 'photo'
                        ? Icon(
                            Icons.photo,
                            size: 16.sp,
                          )
                        : dummyData[index].messagetype == 'video'
                            ? Icon(
                                Icons.videocam,
                                size: 16.sp,
                              )
                            : Container(),
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        dummyData[index].messagetype == 'photo'
                            ? 'Photo'
                            : dummyData[index].messagetype == 'video'
                                ? "Video"
                                : dummyData[index].message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    )
                  ],
                )
              : Text(
                  dummyData[index].message,
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: SizedBox(
            height: 60.h,
            width: 64.w,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dummyData[index].time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  dummyData[index].msgNo != 0.toString()
                      ? Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              dummyData[index].msgNo,
                              style: TextStyle(color: white),
                            ),
                          ),
                        )
                      : Container()
                ]),
          ),
        ),
        cubit.state.selectedChatTile.contains(index)
            ? Divider(
                height: 0,
                color: Colors.grey,
              )
            : const Padding(
                padding: EdgeInsets.only(left: 90.0),
                child: Divider(
                  color: Colors.grey,
                ),
              )
      ],
    );
  }
}
*/

class ChatTileWidget extends StatefulWidget {
  final ChatUsers user;
  const ChatTileWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatTileWidget> createState() => _ChatTileWidgetState();
}

class _ChatTileWidgetState extends State<ChatTileWidget> {
  ChatMessages? _messages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseHelper.getLastMessage(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;

          final userList =
              data?.map((e) => ChatMessages.fromJson(e.data())).toList() ?? [];

          if (userList.isNotEmpty) {
            _messages = userList.first;
          }

          return Column(
            children: [
              ListTile(
                onLongPress: () {
                  _showDeleteDialogue();
                },
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChattingScreen(
                        user: widget.user,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1, 0), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                leading: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => ChatImageDialogue(user: widget.user));

                    // await FirebaseHelper.createGuardLocation(
                    //     'lat', 'long', 'shiftid', 'checkpId', "routeid");
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: widget.user.profileUrl.toString(),
                          fit: BoxFit.fill,
                          width: 60.0,
                          height: 60.0,
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 30,
                              backgroundColor: grey,
                              backgroundImage: NetworkImage(
                                widget.user.profileUrl.toString(),
                              ),
                            );
                          },
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                              ),
                          errorWidget: (context, url, error) => CircleAvatar(
                                radius: 30,
                                child: Image.asset(
                                  'assets/chatProfile.png',
                                  fit: BoxFit.fill,
                                ),
                              )),
                      widget.user.isOnline
                          ? Positioned(
                              top: 40,
                              left: 40,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  border: Border.all(color: white, width: 2),
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
                ),
                title: Text(widget.user.name.toString()),
                subtitle: _messages == null
                    ? Text(
                        _messages != null
                            ? _messages!.message.toString()
                            : "Hey there! I am using SGT",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : FirebaseHelper.user.uid == _messages!.fromId
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _messages != null
                                  ? _messages!.read.isNotEmpty
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
                                  : Container(),
                              _messages?.type == 'photo'
                                  ? Icon(
                                      Icons.photo,
                                      size: 16.sp,
                                    )
                                  : _messages?.type == 'video'
                                      ? Icon(
                                          Icons.videocam,
                                          size: 16.sp,
                                        )
                                      : Container(),
                              SizedBox(
                                width: 140.w,
                                child: Text(
                                  _messages?.type == 'photo'
                                      ? ' Photo'
                                      : _messages?.type == 'video'
                                          ? " Video"
                                          : _messages != null
                                              ? _messages!.message.toString()
                                              : "Hey there! I am using SGT",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _messages?.type == 'photo'
                                  ? Icon(
                                      Icons.photo,
                                      size: 16.sp,
                                    )
                                  : _messages?.type == 'video'
                                      ? Icon(
                                          Icons.videocam,
                                          size: 16.sp,
                                        )
                                      : Container(),
                              SizedBox(
                                width: 140.w,
                                child: Text(
                                  _messages?.type == 'photo'
                                      ? ' Photo'
                                      : _messages?.type == 'video'
                                          ? " Video"
                                          : _messages != null
                                              ? _messages!.message.toString()
                                              : "Hey there! I am using SGT",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              )
                            ],
                          ),
                trailing: SizedBox(
                  height: 60.h,
                  width: 64.w,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _messages == null
                              ? ""
                              : MyDateUtil.getLastMessageTime(
                                  context: context,
                                  time: _messages!.sent.toString()),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        UnreadMessageCount(
                          user: widget.user,
                          messages: _messages,
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: Divider(
                  height: 0,
                  color: Colors.grey,
                ),
              )
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
                  'Delete Guard?',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Are you sure you want to delete this guard from chat?',
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
                              'Cancel',
                              // ignore: deprecated_member_use
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: CustomTheme.primaryColor,
                                  fontSize: 15),
                            ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          border: Border.all(color: CustomTheme.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseHelper.deleteContact(widget.user)
                                .then((value) {
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
}

class UnreadMessageCount extends StatelessWidget {
  final ChatUsers user;
  final ChatMessages? messages;
  UnreadMessageCount({required this.user, this.messages});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseHelper.getUnreadMessages(user),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        }
        var unreadCount = snapshot.data!.docs.length;
        return unreadCount != 0
            ? Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    unreadCount.toString(),
                    style: TextStyle(color: white),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
