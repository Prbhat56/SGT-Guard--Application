import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import '../../utils/const.dart';
import '../widgets/main_appbar_widget.dart';
import 'model/chat_messages_modal.dart';
import 'widgets/chattile_widget.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  List<ChatUsers> userList = [];
  List<ChatMessages> messages = [];

  @override
  void initState() {
    super.initState();

    FirebaseHelper.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      if (FirebaseHelper.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          FirebaseHelper.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseHelper.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
    // LocationDependencyInjection.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'Connect',
      ),
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, top: 16.h, bottom: 6.h, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chats',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    for (var index = 0; index < userList.length; index++) {
                      FirebaseHelper.showAllMessages(userList[index]);
                    }
                    
                  },
                  child: Text(
                    'Mark All As Read',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            color: seconderyColor,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseHelper.getAllUsers(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    userList = data
                            ?.map((e) => ChatUsers.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList() ??
                        [];
                    userList.removeWhere((element) =>
                        element.id == FirebaseHelper.user.uid.toString());

                    if (userList.isNotEmpty) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: userList.length,
                          itemBuilder: (context, index) =>
                              ChatTileWidget(user: userList[index]));
                    } else {
                      return SizedBox(
                        child: Center(
                          child: Text(
                            'No Guard Found',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
/*
class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  List<ChatUsers> userList = [];

  @override
  void initState() {
    super.initState();

    FirebaseHelper.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      if (FirebaseHelper.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          FirebaseHelper.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseHelper.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IslongpressCubit, IslongpressState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: state.selectedChatTile.isNotEmpty
              ? AppBar(
                  //leadingWidth: 50,
                  backgroundColor: white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: black,
                    ),
                    onPressed: () {},
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.read<IslongpressCubit>().removeAll();
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: black,
                          size: 25,
                        ))
                  ],
                )
              : MainAppBarWidget(
                  appBarTitle: 'Connect',
                ),
          backgroundColor: white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.selectedChatTile.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: 16.w, bottom: 6.h),
                      child: Text(
                        'Chats',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, top: 16.h, bottom: 6.h, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chats',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Mark All As Read',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
              Divider(
                thickness: 3,
                color: seconderyColor,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseHelper.getAllUsers(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        userList = data
                                ?.map((e) => ChatUsers.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList() ??
                            [];

                        if (userList.isNotEmpty) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemCount: userList.length,
                              itemBuilder: (context, index) => InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   PageRouteBuilder(
                                      //     transitionDuration:
                                      //         const Duration(milliseconds: 500),
                                      //     pageBuilder: (context, animation,
                                      //             secondaryAnimation) =>
                                      //         ChattingScreen(
                                      //       user: userList[index],
                                      //     ),
                                      //     transitionsBuilder: (context,
                                      //         animation,
                                      //         secondaryAnimation,
                                      //         child) {
                                      //       return SlideTransition(
                                      //         position: Tween<Offset>(
                                      //                 begin: const Offset(1, 0),
                                      //                 end: Offset.zero)
                                      //             .animate(animation),
                                      //         child: child,
                                      //       );
                                      //     },
                                      //   ),
                                      // );
                                    },
                                    child: ChatTileWidget(
                                      index: index,
                                      color: context
                                              .read<IslongpressCubit>()
                                              .state
                                              .selectedChatTile
                                              .contains(index)
                                          ? seconderyColor
                                          : Colors.transparent,
                                      cubit: BlocProvider.of(context),
                                      user: userList[index],
                                    ),
                                  ));
                        } else {
                          return SizedBox(
                            child: Center(
                              child: Text(
                                'No Connections Found',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              )
            ],
          ),
          /*SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 90 * userList.length.toDouble(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userList.length,
                    itemBuilder: (context, index) => ChatTileWidget(
                      index: index,
                      color: context
                              .read<IslongpressCubit>()
                              .state
                              .selectedChatTile
                              .contains(index)
                          ? seconderyColor
                          : Colors.transparent,
                      cubit: BlocProvider.of(context),
                      user: userList[index],
                    ),
                  ),
                )
              ],
            ),
          ),*/
        );
      },
    );
  }
}
*/