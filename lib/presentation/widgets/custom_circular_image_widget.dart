import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';

//custom class to provide different size of circular images
class CustomCircularImage {
  //widge† for small size circularImage
  static Widget getsmCircularImage(String imageUrl, bool isOnline) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: grey,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Positioned(
          bottom: 4,
          left: 43,
          child: isOnline
              ? Container(
                  height: 15,
                  width: 15,
                  decoration: CustomTheme.onlineIndecatorStyle(),
                )
              : Container(),
        )
      ],
    );
  }

//widge† for medium size circularImage
  static getmdCircularImage(String imageUrl, bool isOnline) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: grey,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Positioned(
          bottom: 4,
          left: 43,
          child: isOnline
              ? Container(
                  height: 15,
                  width: 15,
                  decoration: CustomTheme.onlineIndecatorStyle(),
                )
              : Container(),
        )
      ],
    );
  }

//widge† for large size circularImage
  static getlgCircularImage(String imageUrl, bool isActive) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: grey,
          backgroundImage: NetworkImage(imageUrl),
        ),
        isActive
            ? Positioned(
                top: 47,
                left: 54,
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    border: Border.all(color: white, width: 3),
                    color: greenColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
