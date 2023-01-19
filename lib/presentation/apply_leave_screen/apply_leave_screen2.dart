import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';

import '../../helper/navigator_function.dart';
import '../../theme/custom_theme.dart';
import '../widgets/custom_button_widget.dart';
import 'apply_leave_success_screen.dart';

class ApplyLeaveScreen2 extends StatelessWidget {
  const ApplyLeaveScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Apply Leave'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    textfieldTitle: 'Total Missing Shifts On Leave',
                    hintText: '7',
                    isFilled: true),
                CustomTextField(
                    maxLines: 5,
                    textfieldTitle: 'Subject',
                    hintText: 'Something here',
                    isFilled: false),
                CustomTextField(
                  maxLines: 10,
                  textfieldTitle: 'Reason Of Leave',
                  hintText: 'Something here',
                  isFilled: false,
                ),
                SizedBox(
                  height: 100,
                ),
                CustomButtonWidget(
                    buttonTitle: 'Apply',
                    onBtnPress: () {
                      screenNavigator(context, ApplyLeaveSuccess());
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
