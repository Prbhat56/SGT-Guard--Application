import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/custom_theme.dart';
import '../widgets/custom_button_widget.dart';
import 'apply_leave_screen2.dart';
import 'widgets/custom_calender.dart';
import 'package:http/http.dart' as http;

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  static _ApplyLeaveScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ApplyLeaveScreenState>();

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  bool leaveFromclicked = false;
  bool leaveToclicked = false;

  String? fromDate;
  String? toDate;

  DateTime dt1 = DateTime.now();
  DateTime dt2 = DateTime.now();
  TextEditingController _fromText = TextEditingController();
  TextEditingController _toText = TextEditingController();

  var leaveTerms = '';
  bool _termsChecked = false;

  @override
  void initState() {
    super.initState();
    applyLeavePolicy();
  }

  Future<void> applyLeavePolicy() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String apiUrl = baseUrl +
          apiRoutes['leavePolicy']! +
          '?property_owner_id=${prefs.getString('property_owner_id')}';

      Map<String, String> headerData = {
        'Authorization': 'Bearer ${prefs.getString('token')}'
      };
      var response = await http.get(Uri.parse(apiUrl), headers: headerData);

      var responseModel = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setState(() {
          leaveTerms = responseModel['data']['policies'];
        });
        return responseModel;
      } else {
        return responseModel;
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
                  Text('Leave From \*',
                      style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: seconderyMediumColor),
                    child: TextField(
                      controller: _fromText,
                      readOnly: true,
                      obscureText: false,
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          hintText: "Choose From Date",
                          contentPadding: EdgeInsets.only(left: 10, top: 14),
                          hintStyle:
                              TextStyle(fontSize: 12.0, color: primaryColor),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                          )),
                      onTap: () {
                        setState(() {
                          leaveFromclicked = !leaveFromclicked;
                        });
                      },
                    ),
                  ),
                  leaveFromclicked
                      ? CustomCalenderWidget(
                          onCallback: () {
                            _fromText.text = fromDate.toString();
                            dt1 = DateTime.parse(fromDate.toString());
                            setState(() {
                              leaveFromclicked = !leaveFromclicked;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('To \*',
                      style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: seconderyMediumColor),
                    child: TextField(
                      controller: _toText,
                      readOnly: true,
                      obscureText: false,
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          hintText: "Choose To Date",
                          contentPadding: EdgeInsets.only(left: 10, top: 14),
                          hintStyle:
                              TextStyle(fontSize: 12.0, color: primaryColor),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                          )),
                      onTap: () {
                        setState(() {
                          leaveToclicked = !leaveToclicked;
                        });
                      },
                    ),
                  ),
                  leaveToclicked
                      ? OtherCalenderWidget(
                          onCall: () {
                            _toText.text = toDate.toString();
                            dt2 = DateTime.parse(toDate.toString());
                            setState(() {
                              leaveToclicked = !leaveToclicked;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Term & Conditions',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 17,
                          color: CustomTheme.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Container(
                        height: 52 * 5,
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                        (leaveTerms != null ? leaveTerms : ''),
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
                      ),*/
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    decoration: BoxDecoration(
                        // color: AppColors.white,
                        border: Border.all(width: 1, color: CustomTheme.grey),
                        borderRadius:BorderRadius.all(Radius.elliptical(5, 5))),
                    child: Padding(
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
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                (leaveTerms == ''
                                    ? 'No Leave Policy'
                                    : leaveTerms),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  ListTileTheme(
                    horizontalTitleGap: 0,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.only(top: 20),
                      activeColor: primaryColor,
                      title: Text(
                        'I accepted the terms and conditions. Do not apply leave if you do not agree to take the terms and conditions stated here on this page',
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                      value: _termsChecked,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() {
                          _termsChecked = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CustomButtonWidget(
                        buttonTitle: 'Continue',
                        onBtnPress: () {
                          if (_fromText.text.isEmpty) {
                            CommonService().openSnackBar(
                                'Please choose From date', context);
                          } else if (_toText.text.isEmpty) {
                            CommonService()
                                .openSnackBar('Please choose To date', context);
                          } else {
                            dt1.difference(dt2).inDays > 0
                                ? CommonService().openSnackBar(
                                    'From date is greater To date', context)
                                : screenNavigator(
                                    context,
                                    ApplyLeaveScreen2(
                                      difference:dt2.difference(dt1).inDays.toString(),
                                      fromDate: fromDate,
                                      toDate: toDate,
                                    ));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
