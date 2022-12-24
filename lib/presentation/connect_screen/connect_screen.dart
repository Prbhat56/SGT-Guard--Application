import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/issearching/issearching_cubit.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import '../../utils/const.dart';
import 'widgets/chattile_widget.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  // List selectedChatTile = [];

  @override
  Widget build(BuildContext context) {
    print(context.watch<IslongpressCubit>().state.selectedChatTile.isNotEmpty);
    return Scaffold(
      appBar:
          // context
          //         .watch<IslongpressCubit>()
          //         .state
          //         .selectedChatTile
          //         .isNotEmpty
          BlocProvider.of<IslongpressCubit>(context, listen: true)
                  .state
                  .selectedChatTile
                  .isNotEmpty
              // selectedChatTile.isNotEmpty
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
                          BlocProvider.of<IslongpressCubit>(
                            context,
                          ).removeAll();
                          // setState(() {
                          //   selectedChatTile.clear();
                          // });
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
                  leadingWidth: 0,
                  backgroundColor: white,
                  title: BlocProvider.of<IssearchingCubit>(context,
                              listen: true)
                          .state
                          .isSearching
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: grey,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(30, 5, 30, 0),
                                prefixIcon: Icon(
                                  Icons.arrow_back_ios,
                                  color: black,
                                  size: 25,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                hintText: 'Search',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<IssearchingCubit>(context)
                                        .searchingChecker();
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    size: 25,
                                    color: black,
                                  ),
                                )),
                          ),
                        )
                      : Container(),
                  actions: [
                    BlocProvider.of<IssearchingCubit>(context, listen: true)
                            .state
                            .isSearching
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<IssearchingCubit>(context)
                                    .searchingChecker();
                              },
                              icon: Icon(
                                Icons.search,
                                color: black,
                                size: 35,
                              ),
                            ),
                          ),
                  ],
                ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider.of<IslongpressCubit>(context, listen: true)
                    .state
                    .selectedChatTile
                    .isNotEmpty
                // selectedChatTile.isNotEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 10),
                    child: Text(
                      'Connect',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
            BlocProvider.of<IslongpressCubit>(context, listen: true)
                    .state
                    .selectedChatTile
                    .isNotEmpty
                // selectedChatTile.isNotEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                    child: Text(
                      'Chats',
                      style: TextStyle(color: black, fontSize: 20),
                    ),
                  ),
            Divider(
              thickness: 3,
              color: primaryColor,
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: BlocProvider.of<IslongpressCubit>(context, listen: true)
                        .state
                        .selectedChatTile
                        .isNotEmpty
                    ? MediaQuery.of(context).size.height * 4 / 5
                    : MediaQuery.of(context).size.height * 3.56 / 5,
                child: ChatTileListView(
                  cubit: BlocProvider.of<IslongpressCubit>(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Column chatTile(int index, BuildContext context) {
  //   return Column(
  //     children: [
  //       ListTile(
  //         tileColor: BlocProvider.of<IslongpressCubit>(
  //           context,
  //         ).state.selectedChatTile.contains(index)
  //             // selectedChatTile.contains(index)
  //             ? seconderyColor
  //             : null,
  //         onLongPress: () {
  //           BlocProvider.of<IslongpressCubit>(
  //             context,
  //           ).addtoList(index);
  //           // setState(() {
  //           //   selectedChatTile.add(index);
  //           // });
  //           //  print(selectedChatTile[index]);
  //         },
  //         onTap: () {
  //           BlocProvider.of<IslongpressCubit>(context, listen: true)
  //                   .state
  //                   .selectedChatTile
  //                   .contains(index)
  //               // selectedChatTile.contains(index)
  //               ? BlocProvider.of<IslongpressCubit>(
  //                   context,
  //                 ).removefromList(index)
  //               // ? setState(() {
  //               //     selectedChatTile.remove(index);
  //               //   })
  //               : Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => ChattingScreen(index: index)));
  //         },
  //         leading: Stack(
  //           children: [
  //             CircleAvatar(
  //               radius: 30,
  //               backgroundColor: grey,
  //               backgroundImage: NetworkImage(
  //                 dummyData[index].profileUrl,
  //               ),
  //             ),
  //             dummyData[index].isOnline
  //                 ? Positioned(
  //                     top: 40,
  //                     left: 40,
  //                     child: Container(
  //                       height: 15,
  //                       width: 15,
  //                       decoration: BoxDecoration(
  //                         color: greenColor,
  //                         border: Border.all(color: white, width: 2),
  //                         borderRadius: BorderRadius.circular(50),
  //                       ),
  //                     ),
  //                   )
  //                 : Positioned(
  //                     top: 40,
  //                     left: 40,
  //                     child: Container(),
  //                   )
  //           ],
  //         ),
  //         title: Text(dummyData[index].name),
  //         subtitle: dummyData[index].isSendByMe
  //             ? Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   dummyData[index].messagetype == 'not_send'
  //                       ? Icon(
  //                           Icons.av_timer,
  //                           size: 17.sp,
  //                         )
  //                       : Icon(
  //                           Icons.done_all_outlined,
  //                           size: 17.sp,
  //                           color: dummyData[index].ismessageSeen
  //                               ? primaryColor
  //                               : Colors.grey,
  //                         ),
  //                   dummyData[index].messagetype == 'photo'
  //                       ? Icon(
  //                           Icons.photo,
  //                           size: 16.sp,
  //                         )
  //                       : dummyData[index].messagetype == 'video'
  //                           ? Icon(
  //                               Icons.videocam,
  //                               size: 16.sp,
  //                             )
  //                           : Container(),
  //                   SizedBox(
  //                     width: 140.w,
  //                     child: Text(
  //                       dummyData[index].messagetype == 'photo'
  //                           ? 'Photo'
  //                           : dummyData[index].messagetype == 'video'
  //                               ? "Video"
  //                               : dummyData[index].message,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                       softWrap: false,
  //                     ),
  //                   )
  //                 ],
  //               )
  //             : Text(
  //                 dummyData[index].message,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //         trailing: SizedBox(
  //           height: 60.h,
  //           width: 64.w,
  //           child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   dummyData[index].time,
  //                   style: const TextStyle(color: Colors.grey),
  //                 ),
  //                 const SizedBox(
  //                   height: 6,
  //                 ),
  //                 dummyData[index].msgNo != 0.toString()
  //                     ? Container(
  //                         height: 20,
  //                         width: 20,
  //                         decoration: BoxDecoration(
  //                             color: primaryColor,
  //                             borderRadius: BorderRadius.circular(50)),
  //                         child: Center(
  //                           child: Text(
  //                             dummyData[index].msgNo,
  //                             style: TextStyle(color: white),
  //                           ),
  //                         ),
  //                       )
  //                     : Container()
  //               ]),
  //         ),
  //       ),
  //       // BlocProvider.of<IslongpressCubit>(context, listen: true)
  //       //         .state
  //       //         .islongpressed
  //       BlocProvider.of<IslongpressCubit>(context, listen: true)
  //               .state
  //               .selectedChatTile
  //               .contains(index)
  //           // selectedChatTile.contains(index)
  //           ? Divider(
  //               height: 0,
  //               color: Colors.grey,
  //             )
  //           : const Padding(
  //               padding: EdgeInsets.only(left: 90.0),
  //               child: Divider(
  //                 color: Colors.grey,
  //               ),
  //             )
  //     ],
  //   );
  // }

}

class ChatTileListView extends StatelessWidget {
  const ChatTileListView({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final IslongpressCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IslongpressCubit, IslongpressState>(
      listener: (context, state) {
        print('index of listtile ---->${state.selectedChatTile}');
      },
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: dummyData.length,
          itemBuilder: (context, index) => ChatTileWidget(
            index: index,
            color: state.selectedChatTile.contains(index)
                ? seconderyColor
                : Colors.transparent,
            cubit: BlocProvider.of<IslongpressCubit>(context),
          ),

          // Column(
          //   children: [
          //     ListTile(
          //       tileColor:
          //           // BlocProvider.of<IslongpressCubit>(
          //           //   context,
          //           // ).state.selectedChatTile.contains(index)
          //           selectedChatTile.contains(index)
          //               ? seconderyColor
          //               : null,
          //       onLongPress: () {
          //         // BlocProvider.of<IslongpressCubit>(
          //         //   context,
          //         // ).addtoList(index);
          //         setState(() {
          //           selectedChatTile.add(index);
          //         });
          //         print(selectedChatTile[index]);
          //       },
          //       onTap: () {
          //         // BlocProvider.of<IslongpressCubit>(context,
          //         //             listen: true)
          //         //         .state
          //         //         .selectedChatTile
          //         //         .contains(index)
          //         selectedChatTile.contains(index)
          //             // ? BlocProvider.of<IslongpressCubit>(
          //             //     context,
          //             //   ).removefromList(index)
          //             ? setState(() {
          //                 selectedChatTile.remove(index);
          //               })
          //             : Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) =>
          //                         ChattingScreen(index: index)));
          //       },
          //       leading: Stack(
          //         children: [
          //           CircleAvatar(
          //             radius: 30,
          //             backgroundColor: grey,
          //             backgroundImage: NetworkImage(
          //               dummyData[index].profileUrl,
          //             ),
          //           ),
          //           dummyData[index].isOnline
          //               ? Positioned(
          //                   top: 40,
          //                   left: 40,
          //                   child: Container(
          //                     height: 15,
          //                     width: 15,
          //                     decoration: BoxDecoration(
          //                       color: greenColor,
          //                       border:
          //                           Border.all(color: white, width: 2),
          //                       borderRadius: BorderRadius.circular(50),
          //                     ),
          //                   ),
          //                 )
          //               : Positioned(
          //                   top: 40,
          //                   left: 40,
          //                   child: Container(),
          //                 )
          //         ],
          //       ),
          //       title: Text(dummyData[index].name),
          //       subtitle: dummyData[index].isSendByMe
          //           ? Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 dummyData[index].messagetype == 'not_send'
          //                     ? Icon(
          //                         Icons.av_timer,
          //                         size: 17.sp,
          //                       )
          //                     : Icon(
          //                         Icons.done_all_outlined,
          //                         size: 17.sp,
          //                         color: dummyData[index].ismessageSeen
          //                             ? primaryColor
          //                             : Colors.grey,
          //                       ),
          //                 dummyData[index].messagetype == 'photo'
          //                     ? Icon(
          //                         Icons.photo,
          //                         size: 16.sp,
          //                       )
          //                     : dummyData[index].messagetype == 'video'
          //                         ? Icon(
          //                             Icons.videocam,
          //                             size: 16.sp,
          //                           )
          //                         : Container(),
          //                 SizedBox(
          //                   width: 140.w,
          //                   child: Text(
          //                     dummyData[index].messagetype == 'photo'
          //                         ? 'Photo'
          //                         : dummyData[index].messagetype ==
          //                                 'video'
          //                             ? "Video"
          //                             : dummyData[index].message,
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                     softWrap: false,
          //                   ),
          //                 )
          //               ],
          //             )
          //           : Text(
          //               dummyData[index].message,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //       trailing: SizedBox(
          //         height: 60.h,
          //         width: 64.w,
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Text(
          //                 dummyData[index].time,
          //                 style: const TextStyle(color: Colors.grey),
          //               ),
          //               const SizedBox(
          //                 height: 6,
          //               ),
          //               dummyData[index].msgNo != 0.toString()
          //                   ? Container(
          //                       height: 20,
          //                       width: 20,
          //                       decoration: BoxDecoration(
          //                           color: primaryColor,
          //                           borderRadius:
          //                               BorderRadius.circular(50)),
          //                       child: Center(
          //                         child: Text(
          //                           dummyData[index].msgNo,
          //                           style: TextStyle(color: white),
          //                         ),
          //                       ),
          //                     )
          //                   : Container()
          //             ]),
          //       ),
          //     ),

          //     // BlocProvider.of<IslongpressCubit>(context, listen: true)
          //     //         .state
          //     //         .selectedChatTile
          //     //         .contains(index)
          //     selectedChatTile.contains(index)
          //         ? Divider(
          //             height: 0,
          //             color: Colors.grey,
          //           )
          //         : const Padding(
          //             padding: EdgeInsets.only(left: 90.0),
          //             child: Divider(
          //               color: Colors.grey,
          //             ),
          //           )
          //   ],
          // ),
        );
      },
    );
  }
}
