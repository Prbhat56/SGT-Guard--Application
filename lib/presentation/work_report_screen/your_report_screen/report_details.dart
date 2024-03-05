import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class ReportDetailsPage extends StatelessWidget {
  ReportDetailsPage({
    super.key,
    required this.recentReportDatum,
  });
  final ReportResponse recentReportDatum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        shadowColor: Color.fromARGB(255, 186, 185, 185),
        elevation: 6,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Report Details',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Property Name',
                      style: CustomTheme.blueTextStyle(17, FontWeight.w700)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: seconderyMediumColor),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 10, bottom: 0, left: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        fillColor: seconderyMediumColor,
                        focusColor: primaryColor,
                        hintText: recentReportDatum.reportType,
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade200,
              thickness: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title',
                      style: CustomTheme.blueTextStyle(17, FontWeight.w700)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6), color: white),
                    child: Scrollbar(
                      child: TextFormField(
                        maxLines: null,
                        initialValue: recentReportDatum.subject,
                        keyboardType: TextInputType.multiline,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 0, left: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          focusColor: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade200,
              thickness: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notes',
                      style: CustomTheme.blueTextStyle(17, FontWeight.w700)),
                  SizedBox(
                    height: 10,
                  ),
                  Scrollbar(
                    child: TextFormField(
                      maxLines: null,
                      initialValue: recentReportDatum.notes.toString(),
                      keyboardType: TextInputType.multiline,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 10, bottom: 0, left: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade200,
              thickness: 4,
            ),
            Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 120, // here set custom Height You Want
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/sgt_logo.jpg',
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
