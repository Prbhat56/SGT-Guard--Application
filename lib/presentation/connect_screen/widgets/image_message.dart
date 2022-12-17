import 'package:flutter/material.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({super.key});

  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      width: 172,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset('assets/img1.png'),
              Image.asset('assets/img2.png'),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/img3.png'),
              Container(
                  height: 82,
                  width: 82,
                  color: Colors.grey,
                  child: Center(child: Text('3+')))
            ],
          ),
        ],
      ),
    );
  }
}
