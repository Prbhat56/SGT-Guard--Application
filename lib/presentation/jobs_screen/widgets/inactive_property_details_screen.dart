import 'package:flutter/material.dart';
import '../../../utils/const.dart';

class InActivePropertyDetailsScreen extends StatelessWidget {
  const InActivePropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
      ),
    );
  }
}
