import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/apply_leave_screen/apply_leave_screen.dart';
import 'package:sgt/utils/const.dart';

class CustomCalenderWidget extends StatefulWidget {
  final VoidCallback onCallback;
  CustomCalenderWidget({super.key, required this.onCallback});

  @override
  _CustomCalenderWidgetState createState() => new _CustomCalenderWidgetState();
}

class _CustomCalenderWidgetState extends State<CustomCalenderWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1]),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted = formatter.format(date);
            ApplyLeaveScreen.of(context)?.fromDate = formatted;
          });
          widget.onCallback();
        },
        weekendTextStyle: TextStyle(
          color: black,
        ),
        weekFormat: false,
        height: 380.0,
        daysHaveCircularBorder: true,
        todayTextStyle: TextStyle(color: black),
        todayButtonColor: white,
        todayBorderColor: white,
        minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
      ),
    );
  }
}

class OtherCalenderWidget extends StatefulWidget {
  final VoidCallback onCall;
  OtherCalenderWidget({super.key, required this.onCall});

  @override
  _OtherCalenderWidgetState createState() => new _OtherCalenderWidgetState();
}

class _OtherCalenderWidgetState extends State<OtherCalenderWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1]),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted = formatter.format(date);
            ApplyLeaveScreen.of(context)?.toDate = formatted;
          });
          widget.onCall();
        },
        weekendTextStyle: TextStyle(
          color: black,
        ),
        weekFormat: false,
        height: 380.0,
        daysHaveCircularBorder: true,
        todayTextStyle: TextStyle(color: black),
        todayButtonColor: white,
        todayBorderColor: white,
        minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
      ),
    );
  }
}
