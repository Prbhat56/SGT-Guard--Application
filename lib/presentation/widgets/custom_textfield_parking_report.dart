import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';

// ignore: must_be_immutable
class CustomParkingTextField extends StatelessWidget {
  CustomParkingTextField(
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
          RichText(
              text: TextSpan(
                  text: textfieldTitle,
                  style: textfieldTitle == 'Title' ? TextStyle(
                                fontSize: 17,
                                color: CustomTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ) :CustomTheme.textField_Headertext_Style,
                  children: [
                TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                    ))
              ])),
          // Text(
          //   textfieldTitle,
          //   style: CustomTheme.textField_Headertext_Style,
          //   textScaleFactor: 1.0,
          // ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: 
            
      InputDecoration(
      contentPadding: isFilled
          ? EdgeInsets.only(top: 0, bottom: 0, left: 10)
          : EdgeInsets.all(10),
      enabledBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(
          width: 1, color: CustomTheme.seconderyMediumColor), 
    ),
      // OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color:CustomTheme.greenColor)),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color:CustomTheme.primaryColor)),
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color:CustomTheme.seconderyMediumColor)),
      // disabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color:CustomTheme.seconderyMediumColor)),
      filled: isFilled,
      fillColor: CustomTheme.seconderyMediumColor,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      focusColor: CustomTheme.primaryColor,
    )
            
            // CustomTheme.textfieldDecoration(
            //     hintText, isFilled, isSearching!),
          ),
        ],
      ),
    );
  }
}
