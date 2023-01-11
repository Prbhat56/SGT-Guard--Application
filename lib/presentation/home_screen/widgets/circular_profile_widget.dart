import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_functions.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import '../../connect_screen/widgets/chatting_screen.dart';
import '../../widgets/custom_circular_image_widget.dart';

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
                    screenNavigator(context, ChattingScreen(index: index));
                  },
                  child: CustomCircularImage.getmdCircularImage(
                      dummyData[index].profileUrl, dummyData[index].isOnline),
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
