import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class SuccessPopup extends StatelessWidget {
  const SuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        content: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: greenColor,
                size: 60,
              ),
              Text(
                "Done",
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "Report has been sent\n successfully!",
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Product-Price-Promotion-Place (Survival)