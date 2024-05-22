import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/custom_theme.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Towed',
            style: TextStyle(
                fontSize: 17,
                color: CustomTheme.primaryColor,
                fontWeight: FontWeight.w500),
            textScaleFactor: 1.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                items: ['yes'.tr, 'no'.tr].map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                hint: Text(
                  'Select Yes or No',
                  style: const TextStyle(color: Colors.grey),
                ),
                onChanged: (v) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
