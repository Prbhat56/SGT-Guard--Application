import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sgt/presentation/connect_screen/widgets/custom_shape.dart';
import '../../../utils/const.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final String message;
  const ReceivedMessageScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: CustomShape(Colors.grey[300]!),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
