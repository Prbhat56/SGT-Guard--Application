// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/const.dart';
import '../cubit/islongpressed/islongpress_cubit.dart';
import 'chat_model.dart';
import 'chatting_screen.dart';

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
            // cubit.addtoList(index);
            BlocProvider.of<IslongpressCubit>(
              context,
            ).state.selectedChatTile.contains(index)
                ? null
                : BlocProvider.of<IslongpressCubit>(context).addtoList(index);
          },
          onTap: () {
            // BlocProvider.of<IslongpressCubit>(
            //   context,
            // ).state.selectedChatTile.contains(index)
            cubit.state.selectedChatTile.contains(index)
                ? BlocProvider.of<IslongpressCubit>(context)
                    .removefromList(index)
                // cubit.removefromList(index)

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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ChattingScreen(index: index),
            //     ),
            //   );
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
        BlocProvider.of<IslongpressCubit>(context, listen: true)
                .state
                .selectedChatTile
                .contains(index)
            // cubit.state.selectedChatTile.contains(index)
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
