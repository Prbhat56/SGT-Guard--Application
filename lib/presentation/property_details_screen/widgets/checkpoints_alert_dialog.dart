import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/utils/const.dart';

class CheckpointsAlertDialog extends StatelessWidget {
  const CheckpointsAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 16,
                ),
                Text(' To view checkpoint details you',
                    style: TextStyle(color: Colors.red))
              ],
            ),
          ),
          Text('have to start the shift!', style: TextStyle(color: Colors.red)),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: primaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
            child: CustomButtonWidget(
                buttonTitle: 'Go Back',
                onBtnPress: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
