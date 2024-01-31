import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_emergency_report.dart';

import '../../../../theme/custom_theme.dart';

class EmergencyDateTimeWidget extends StatefulWidget {
  const EmergencyDateTimeWidget({super.key});

  @override
  State<EmergencyDateTimeWidget> createState() =>
      _EmergencyDateTimeWidgetState();
}

class _EmergencyDateTimeWidgetState extends State<EmergencyDateTimeWidget> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 17,
                      color: CustomTheme.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    controller: dateinput,
                    decoration: InputDecoration(
                      hintText: DateFormat('yyyy-MM-dd')
                          .format(DateTime.now())
                          .toString(),
                      hintStyle: TextStyle(color: CustomTheme.primaryColor),
                      focusColor: CustomTheme.primaryColor,
                    ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text = formattedDate;
                          EmergencyReportScreen.of(context)!.dateValue =
                              formattedDate;
                          StaticEmergencyReportScreen.of(context)!.dateValue =
                              formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 17,
                      color: CustomTheme.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    controller: timeinput,
                    decoration: InputDecoration(
                      hintText: DateFormat('HH:mm:ss').format(DateTime.now()),
                      hintStyle: TextStyle(color: CustomTheme.primaryColor),
                      focusColor: CustomTheme.primaryColor,
                    ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child ?? Container(),
                          );
                        },
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        // DateTime parsedTime = DateFormat.jm()
                        //     .parse(pickedTime.format(context).toString());
                        // //converting to DateTime so that we can further format on different pattern.
                        // print(parsedTime); //output 1970-01-01 22:53:00.000
                        // String formattedTime =
                        //     DateFormat('HH:mm:ss').format(parsedTime);
                        // print(formattedTime); //output 14:59:00
                        //var pickTimes = pickedTime.format12Hour(context);
                        var dt = DateFormat("h:mm a")
                            .parse(pickedTime.format(context));
                        var formattedTime = DateFormat.Hms().format(dt);

                        setState(() {
                          timeinput.text = formattedTime;
                          EmergencyReportScreen.of(context)!.timeValue =
                              formattedTime;
                          StaticEmergencyReportScreen.of(context)!.timeValue =
                              formattedTime;    //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
