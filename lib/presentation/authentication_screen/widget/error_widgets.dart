import 'package:flutter/material.dart';

class CustomErrorWidget {
  //email error widget function
  static emailError() {
    return SizedBox(
      width: 143,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 17,
          ),
          Text(
            ' Email ID is Incorrect',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ),
    );
  }

//password error widget function
  static passwordError() {
    return SizedBox(
      width: 143,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 17,
          ),
          Text(
            ' Wrong password',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
