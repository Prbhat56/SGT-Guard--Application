import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedChooseFileWidget extends StatefulWidget {
  final String? title;
  double? height = 20;
  DottedChooseFileWidget({super.key, this.title, this.height});

  @override
  State<DottedChooseFileWidget> createState() => _DottedChooseFileWidgetState();
}

class _DottedChooseFileWidgetState extends State<DottedChooseFileWidget> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: Colors.blue,
      strokeWidth: 2,
      dashPattern: [10, 3],
      radius: Radius.circular(10),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: widget.height ?? 20, horizontal: 5),
        child: Center(
            child: Text(
          widget.title ?? 'Choose a File',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
