import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/utils/const.dart';

class ChatImageDialogue extends StatelessWidget {
  const ChatImageDialogue({super.key, required this.user});
  final ChatUsers user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .35,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name.toString().capitalized(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: CachedNetworkImage(
                      imageUrl: user.profileUrl.toString(),
                      fit: BoxFit.fill,
                      width: 220,
                      height: 220,
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 112,
                          child: CircleAvatar(
                            radius: 110,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                              user.profileUrl.toString(),
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                            'assets/chatProfile.png',
                            fit: BoxFit.fill,
                          )),
                ),
              ],
            ),
          )),
    );
  }
}
