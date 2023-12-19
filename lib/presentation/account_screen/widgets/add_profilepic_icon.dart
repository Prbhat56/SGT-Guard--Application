import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

class AddProfilePicIcon extends StatelessWidget {
  const AddProfilePicIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: CustomTheme.primaryColor,
          borderRadius: BorderRadius.circular(50)),
      child: const Icon(
        Icons.edit,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
