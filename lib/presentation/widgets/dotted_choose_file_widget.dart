import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedChooseFileWidget extends StatelessWidget {
  const DottedChooseFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: Colors.blue,
      strokeWidth: 2,
      dashPattern: [10, 3],
      radius: Radius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text(
          'Choose a File',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
