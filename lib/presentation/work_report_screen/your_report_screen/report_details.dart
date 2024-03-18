import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class ReportDetailsPage extends StatefulWidget {
  ReportDetailsPage({
    super.key,
    required this.recentReportDatum,
    this.imgUrl,
  });
  String? imgUrl;
  final ReportResponse recentReportDatum;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
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
          widget.recentReportDatum.reportType.toString(),
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
                        hintText:
                            widget.recentReportDatum.propertyId.toString(),
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:16.0,right:16.0,bottom:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.event_note,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.recentReportDatum.emergencyDate,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomTheme.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm_on,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.recentReportDatum.emergencyTime, // api response pending
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:CustomTheme.primaryColor),
                      ),
                    ],
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
                        initialValue: widget.recentReportDatum.subject,
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
                      initialValue: widget.recentReportDatum.notes.toString(),
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
                  itemCount: widget.recentReportDatum.images!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                          imageUrl: widget.imgUrl! +
                              '${widget.recentReportDatum.images!.length != 0 ? widget.recentReportDatum.images![index].toString() : ''}',
                          fit: BoxFit.fill,
                          width: 60,
                          height: 60,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                              ),
                          errorWidget: (context, url, error) => Image.asset(
                                'assets/sgt_logo.jpg',
                                fit: BoxFit.fill,
                              )),
                      //  Image.asset(
                      //   'assets/sgt_logo.jpg',
                      //   fit: BoxFit.fill,
                      // ),
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
