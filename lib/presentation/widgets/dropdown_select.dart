import 'package:flutter/material.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';

// ignore: must_be_immutable
class CustomUnderlineDropdownWidget extends StatelessWidget {
  CustomUnderlineDropdownWidget({
    Key? key,
    required this.dropdownTitle,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    this.bottomPadding = 25,
  });

  final String dropdownTitle;
  final String dropdownValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dropdownTitle,
            style: CustomTheme.textField_Headertext_Style,
            textScaleFactor: 1.0,
          ),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: seconderyColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
