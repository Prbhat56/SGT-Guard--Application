import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';

class MediaUploadingWidget extends StatelessWidget {
  const MediaUploadingWidget(
      {super.key,
      required this.imageFileList,
      required this.imageNames,
      required this.clickClose,
      required this.index});
  final List<XFile> imageFileList;
  final int index;
  final List imageNames;
  final VoidCallback clickClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            margin: EdgeInsets.all(5),
            height: 60,
            width: 60,
            alignment: Alignment.center,
            child: Image.file(File(imageFileList[index].path))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 190, child: Text(imageNames[index], style: TextStyle())),
            Row(
              children: [
                Container(
                  height: 4,
                  width: 200,
                  decoration: BoxDecoration(color: primaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.check_circle_outline,
                  color: greenColor,
                  size: 20,
                ),
                SizedBox(width: 5),
              ],
            )
          ],
        ),
        Spacer(),
        InkWell(
          onTap: clickClose,
          child: Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: primaryColor,
                ),
              ),
              child: Icon(
                Icons.close,
                size: 15,
              )),
        )
      ]),
    );
  }
}
