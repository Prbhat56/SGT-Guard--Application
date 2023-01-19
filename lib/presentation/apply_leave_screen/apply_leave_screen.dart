import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/utils/const.dart';
import '../../theme/custom_theme.dart';
import '../widgets/custom_button_widget.dart';
import 'apply_leave_screen2.dart';
import 'widgets/choose_date_widget.dart';
import 'widgets/custom_calender.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  bool leaveFromclicked = false;
  bool leaveToclicked = false;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Apply Leave'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Leave From',
                    style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 6,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        leaveFromclicked = !leaveFromclicked;
                      });
                    },
                    child: ChooseDateWidget()),
                SizedBox(
                  height: 25,
                ),
                leaveFromclicked ? CustomCalenderWidget() : Container(),
                Text('To',
                    style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      leaveToclicked = !leaveToclicked;
                    });
                  },
                  child: ChooseDateWidget(),
                ),
                leaveToclicked ? CustomCalenderWidget() : Container(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Term & Conditions',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 52 * 5,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8, right: 6),
                                height: 3,
                                width: 3,
                                color: black,
                              ),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 120,
                ),
                CustomButtonWidget(
                    buttonTitle: 'Continue',
                    onBtnPress: () {
                      screenNavigator(context, ApplyLeaveScreen2());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
