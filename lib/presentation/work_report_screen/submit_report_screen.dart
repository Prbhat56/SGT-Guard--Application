import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import '../../utils/const.dart';
import '../property_details_screen/widgets/property_media_preview_screen.dart';
import 'report_success_screen.dart';
import 'widget/report_pdf_widget.dart';
import 'widget/success_popup.dart';
import 'work_report_screen.dart';

class SubmitReportScreen extends StatefulWidget {
  const SubmitReportScreen({super.key});

  @override
  State<SubmitReportScreen> createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  List<String> tasksData = [
    "Met with manager",
    "Checked server room",
    "Checked server room",
    "Take a tour of parking",
    "Check car number 5298",
    "Create a general report",
    "Check all security cameras",
    "Create parking report",
    "Take a tour of server room",
  ];
  List<bool> checkbox = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<int> pdf = [];

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ReportTypeCubit>().state;
    print(cubit.isparkingReport);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Checkpoint 1 Details',
            style: TextStyle(color: black),
            textScaleFactor: 1.0,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                          height: 88,
                          width: 122,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                          height: 88,
                          width: 122,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                              height: 88,
                              width: 122,
                            ),
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PropertyMediaPreviewScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 85,
                                width: 122,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '+2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.amber,
                      height: 28.2 * tasksData.length.toDouble(),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: tasksData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(bottom: 11),
                              height: 16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tasksData[index],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Checkbox(
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          checkbox[index] = v!;
                                        },
                                      );
                                      print(v);
                                    },
                                    value: checkbox[index],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Additional comments',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          '(Optional)',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          hintText: 'Something here',
                          hintStyle: TextStyle(color: grey),
                          focusColor: primaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Generate Report',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    cubit.isgeneralReport
                        ? PdfReport(
                            title: 'General Report.pdf',
                          )
                        : Container(),
                    cubit.ismaintenanceReport
                        ? PdfReport(
                            title: 'Maintenance Report.pdf',
                          )
                        : Container(),
                    cubit.isparkingReport
                        ? PdfReport(
                            title: 'Parking Report.pdf',
                          )
                        : Container(),
                    cubit.isemergencyReport
                        ? PdfReport(
                            title: 'Emergency Report.pdf',
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    cubit.isgeneralReport ||
                            cubit.ismaintenanceReport ||
                            cubit.isparkingReport ||
                            cubit.isemergencyReport
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                              'Add Another Report',
                              style: TextStyle(fontSize: 17),
                            ),
                          )
                        : Container(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          pdf.add(1);
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WorkReportScreen();
                        }));
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: primaryColor,
                        radius: Radius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 50,
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: Colors.grey,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: Center(
                  child: CupertinoButton(
                      disabledColor: seconderyColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 15),
                      color: primaryColor,
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 20),
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => SuccessPopup());
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const ReportSuccessScreen(
                        //     isSubmitReportScreen: true,
                        //   );
                        // }));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
