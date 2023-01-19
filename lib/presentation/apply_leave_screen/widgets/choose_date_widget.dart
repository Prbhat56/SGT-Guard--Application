import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

class ChooseDateWidget extends StatelessWidget {
  const ChooseDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: CustomTheme.seconderyColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Choose Date',
            style: TextStyle(color: CustomTheme.primaryColor, fontSize: 12),
          ),
          Icon(
            Icons.expand_more,
            color: CustomTheme.primaryColor,
          )
        ],
      ),
    );
  }
}
