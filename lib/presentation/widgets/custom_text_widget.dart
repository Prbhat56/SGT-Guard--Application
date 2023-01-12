import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';

class TextFieldHeaderWidget extends StatelessWidget {
  const TextFieldHeaderWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomTheme.textField_Headertext_Style,
    );
  }
}

class TextStyleWidget1 extends StatelessWidget {
  const TextStyleWidget1(
      {super.key,
      required this.title,
      required this.fontsize,
      required this.titleValue});
  final String title;
  final double fontsize;
  final String titleValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: CustomTheme.blackTextStyle(fontsize),
        ),
        Text(
          titleValue,
          style: CustomTheme.blueTextStyle(fontsize, FontWeight.w400),
        ),
      ],
    );
  }
}
