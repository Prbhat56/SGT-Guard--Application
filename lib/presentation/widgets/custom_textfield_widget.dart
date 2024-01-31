import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.textfieldTitle,
      required this.hintText,
      required this.isFilled,
      this.maxLines = 1,
      this.isSearching = false,
      this.keyboardType = TextInputType.text,
      this.controller});
  final String textfieldTitle;
  final String hintText;
  TextEditingController? controller;
  final bool isFilled;
  int? maxLines;
  bool? isSearching;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textfieldTitle,
            style: CustomTheme.textField_Headertext_Style,
            textScaleFactor: 1.0,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: CustomTheme.textfieldDecoration(
                hintText, isFilled, isSearching!),
          ),
        ],
      ),
    );
  }
}
