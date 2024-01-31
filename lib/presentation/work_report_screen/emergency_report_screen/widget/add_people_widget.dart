import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import '../../../../theme/custom_theme.dart';
import '../../../widgets/custom_underline_textfield_widget.dart';

/*
class AddPeopleWidget extends StatefulWidget {
  final VoidFutureCallBack onCallback;
  final String title;
  final int number;
  final List<TextEditingController> peopleName;
  final List<TextEditingController> peoplePhone;
  AddPeopleWidget({
    super.key,
    required this.onCallback,
    required this.title,
    required this.number,
    required this.peopleName,
    required this.peoplePhone,
  });

  @override
  State<AddPeopleWidget> createState() => _AddPeopleWidgetState();
}

class _AddPeopleWidgetState extends State<AddPeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: CustomTheme.blackTextStyle(17),
          textScaleFactor: 1.0,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 175 * widget.number.toDouble(),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.number,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomUnderlineTextFieldWidget(
                      textfieldTitle: 'Name',
                      hintText: 'Name',
                      controller: widget.peopleName[index],
                    ),
                    CustomUnderlineTextFieldWidget(
                      textfieldTitle: 'Phone Number',
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.number,
                      controller: widget.peoplePhone[index],
                    ),
                  ],
                );
              }),
        ),
        GestureDetector(
          onTap: widget.onCallback,
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
}*/
