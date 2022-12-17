import 'package:flutter/material.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import 'package:sgt/utils/const.dart';

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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: grey,
                  backgroundImage: NetworkImage(
                    dummyData[index].profileUrl,
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
