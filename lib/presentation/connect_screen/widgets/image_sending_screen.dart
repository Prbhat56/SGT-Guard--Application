import 'dart:io';
import 'package:flutter/material.dart';

class ImageSendingScreen extends StatefulWidget {
  const ImageSendingScreen({super.key, required this.file});
  final File file;
  @override
  State<ImageSendingScreen> createState() => _ImageSendingScreenState();
}

class _ImageSendingScreenState extends State<ImageSendingScreen> {
  @override
  Widget build(BuildContext context) {
    print('---->${widget.file}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 4.5 / 5,
                    child: Image.file(
                      widget.file,
                      height: MediaQuery.of(context).size.height * 4.5 / 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.white))
                ],
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 20),
                    hintText: 'Daniel Santio',
                    hintStyle: TextStyle(color: Colors.white),
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusColor: Colors.white,
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
