import 'package:flutter/material.dart';
import '../../../utils/const.dart';

class PdfReport extends StatelessWidget {
  const PdfReport({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: primaryColor),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(color: primaryColor),
                  )
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: primaryColor,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(color: primaryColor),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
    ;
  }
}
