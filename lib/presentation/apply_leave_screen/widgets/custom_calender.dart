import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:sgt/utils/const.dart';

class CustomCalenderWidget extends StatefulWidget {
  CustomCalenderWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CustomCalenderWidgetState createState() => new _CustomCalenderWidgetState();
}

class _CustomCalenderWidgetState extends State<CustomCalenderWidget> {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: seconderyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: black,
        ),
        weekFormat: false,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,
      ),
    );
  }
}
