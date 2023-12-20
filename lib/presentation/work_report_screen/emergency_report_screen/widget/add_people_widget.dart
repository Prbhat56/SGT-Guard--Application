import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../theme/custom_theme.dart';
import '../../../widgets/custom_underline_textfield_widget.dart';

class AddPeopleWidget extends StatelessWidget {
  final VoidFutureCallBack onCallback;
  final String title;
  final int number;
  final TextEditingController peopleName;
  final TextEditingController peoplePhone;
  AddPeopleWidget({
    super.key,
    required this.onCallback,
    required this.title,
    required this.number,
    required this.peopleName,
    required this.peoplePhone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomTheme.blackTextStyle(17),
          textScaleFactor: 1.0,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 175 * number.toDouble(),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: number,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomUnderlineTextFieldWidget(
                      textfieldTitle: 'Name',
                      hintText: 'Name',
                      controller: peopleName,
                    ),
                    CustomUnderlineTextFieldWidget(
                      textfieldTitle: 'Phone Number',
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.number,
                      controller: peoplePhone,
                    ),
                  ],
                );
              }),
        ),
        GestureDetector(
          onTap: onCallback,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: CustomTheme.primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              'Add peoples +',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
