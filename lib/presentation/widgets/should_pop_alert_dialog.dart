import 'package:flutter/material.dart';

class ShouldPopAlertDialog extends StatelessWidget {
  const ShouldPopAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          const Text('Do you want to go close the app?', textScaleFactor: 1.0),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Container(
            height: 30,
            width: 40,
            padding: const EdgeInsets.only(
              top: 6,
              left: 15,
            ),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(4)),
            child: const Text(
              "No",
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Container(
            height: 30,
            width: 40,
            padding: const EdgeInsets.only(
              top: 6,
              left: 12,
            ),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(4)),
            child: const Text(
              "Yes",
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
