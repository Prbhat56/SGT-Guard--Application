import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
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
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);

  static Widget _eventIcon = Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 2, 10),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: seconderyColor, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        customDayBuilder: (
          /// you can provide your own build function to make custom day containers
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.day == 15) {
            return Center(
              child: Icon(Icons.local_airport),
            );
          } else {
            return null;
          }
        },
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     //custom icon
    //     Container(
    //       margin: EdgeInsets.symmetric(horizontal: 16.0),
    //       child: _calendarCarousel,
    //     ), // This trailing comma makes auto-formatting nicer for build methods.
    //     //custom icon without header
    //     Container(
    //       margin: EdgeInsets.only(
    //         top: 30.0,
    //         bottom: 16.0,
    //         left: 16.0,
    //         right: 16.0,
    //       ),
    //       child: new Row(
    //         children: <Widget>[
    //           Expanded(
    //               child: Text(
    //             _currentMonth,
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 24.0,
    //             ),
    //           )),
    //           TextButton(
    //             child: Text('PREV'),
    //             onPressed: () {
    //               setState(() {
    //                 _targetDateTime = DateTime(
    //                     _targetDateTime.year, _targetDateTime.month - 1);
    //                 _currentMonth = DateFormat.yMMM().format(_targetDateTime);
    //               });
    //             },
    //           ),
    //           TextButton(
    //             child: Text('NEXT'),
    //             onPressed: () {
    //               setState(() {
    //                 _targetDateTime = DateTime(
    //                     _targetDateTime.year, _targetDateTime.month + 1);
    //                 _currentMonth = DateFormat.yMMM().format(_targetDateTime);
    //               });
    //             },
    //           )
    //         ],
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.symmetric(horizontal: 16.0),
    //       child: _calendarCarouselNoHeader,
    //     ), //
    //   ],
    // );
  }
}
