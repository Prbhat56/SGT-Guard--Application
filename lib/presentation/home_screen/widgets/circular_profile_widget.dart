import 'package:flutter/material.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import 'package:sgt/utils/const.dart';

import '../../connect_screen/widgets/chatting_screen.dart';

class CircularProfile extends StatelessWidget {
  const CircularProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dummyData.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: grey,
                        backgroundImage: NetworkImage(
                          dummyData[index].profileUrl,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        left: 43,
                        child: dummyData[index].isOnline
                            ? Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  border: Border.all(color: white, width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    dummyData[index].name,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          }),
    );
  }
}
