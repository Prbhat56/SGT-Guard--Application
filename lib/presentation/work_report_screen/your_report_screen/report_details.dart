import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        toolbarHeight: 48.h,
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
        title: Align(
          alignment: Alignment(-1.1.w, 0.w),
          child: Text(
            widget.recentReportDatum.reportType.toString() + ' Report ',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
          ),
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
                  Text('property_name'.tr,
                      style: CustomTheme.blueTextStyle(17.sp, FontWeight.w700)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: seconderyMediumColor),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 10.h, bottom: 0, left: 10.w),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        fillColor: seconderyMediumColor,
                        focusColor: primaryColor,
                        hintText:
                            widget.recentReportDatum.propertyName.toString(),
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.event_note,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        widget.recentReportDatum.createDate.toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: CustomTheme.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm_on,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        widget.recentReportDatum.createTime
                            .toString(), // api response pending
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: CustomTheme.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 3.h,
              color: Colors.grey.shade200,
              thickness: 4.w,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title',
                      style: CustomTheme.blueTextStyle(17.sp, FontWeight.w700)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r), color: white),
                    child: Scrollbar(
                      child: TextFormField(
                        maxLines: null,
                        initialValue: widget.recentReportDatum.subject,
                        keyboardType: TextInputType.multiline,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 10.h, bottom: 0, left: 10.w),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
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
              height: 3.h,
              color: Colors.grey.shade200,
              thickness: 4.w,
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('notes'.tr,
                      style: CustomTheme.blueTextStyle(17.sp, FontWeight.w700)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Scrollbar(
                    child: TextFormField(
                      maxLines: null,
                      initialValue: widget.recentReportDatum.notes.toString(),
                      keyboardType: TextInputType.multiline,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 10.h, bottom: 0, left: 10.w),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
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
              height: 3.h,
              color: Colors.grey.shade200,
              thickness: 4.w,
            ),
            Container(
              height: 300.h,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.w,
                    mainAxisExtent: 120.w, // here set custom Height You Want
                  ),
                  itemCount: widget.recentReportDatum.images!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CachedNetworkImage(
                          imageUrl: widget.imgUrl! +
                              '${widget.recentReportDatum.images!.length != 0 ? widget.recentReportDatum.images![index].toString() : ''}',
                          fit: BoxFit.fill,
                          width: 166.w,
                          height: 130.h,
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
