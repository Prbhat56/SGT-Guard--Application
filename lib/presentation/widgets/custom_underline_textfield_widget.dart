import 'package:flutter/material.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';

// ignore: must_be_immutable
class CustomUnderlineTextFieldWidget extends StatelessWidget {
  CustomUnderlineTextFieldWidget({
    super.key,
    required this.textfieldTitle,
    required this.hintText,
    this.obscureText = false,
    this.readonly = false,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.bottomPadding = 25,
  });
  final String textfieldTitle;
  final String hintText;
  TextEditingController? controller;
  final bool obscureText;
  ValueChanged<String>? onChanged;
  Widget? suffixIcon;
  bool? readonly;
  double bottomPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textfieldTitle,
            style: CustomTheme.textField_Headertext_Style,
            textScaleFactor: 1.0,
          ),
          TextFormField(
            onChanged: onChanged,
            readOnly: readonly!,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: seconderyColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              hintStyle: const TextStyle(color: Colors.grey),
              focusColor: primaryColor,
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
