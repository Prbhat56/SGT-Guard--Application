// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/const.dart';

class CheckPointListsWidget extends StatelessWidget {
  const CheckPointListsWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.iscompleted,
  }) : super(key: key);
  final String title;
  final String imageUrl;
  final String iscompleted;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 62,
              width: 62,
              child: Image.network(
                fit: BoxFit.contain,
                imageUrl,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 138.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    iscompleted,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Divider(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
