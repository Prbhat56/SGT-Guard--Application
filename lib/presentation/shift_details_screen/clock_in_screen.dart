import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/presentation/time_sheet_screen/check_point_screen.dart';
import '../../utils/const.dart';

class ClockInScreen extends StatefulWidget {
  const ClockInScreen({super.key});

  @override
  State<ClockInScreen> createState() => _ClockInScreenState();
}

class _ClockInScreenState extends State<ClockInScreen> {
  bool isClockedIn = true;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Clocked In',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w400),
          ),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 25,
            ),
            SvgPicture.asset('assets/green_tick.svg'),
            const SizedBox(
              height: 10,
            ),
            Text(
              'You are currently clocked in\n and ready to go!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: primaryColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    seconderyColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  // height: 350,
                  width: 311,
                  decoration: BoxDecoration(
                    color: seconderyLightColor,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: seconderyColor, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 216, 216, 216),
                        offset: Offset(0, 20),
                        blurRadius: 20,
                        spreadRadius: 0.1,
                      ),
                    ],
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: grey,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Matheus Paolo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      'Greylock Security',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'Property',
                      style: TextStyle(fontSize: 15, color: primaryColor),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Rivi Properties',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Guard Post Duties',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Day:',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          const Text(
                            ' Monday, October 24',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Shift Time:',
                            style: TextStyle(fontSize: 13, color: primaryColor),
                          ),
                          const Text(
                            ' 10:00 AM - 04:00 PM',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style:
                                  TextStyle(fontSize: 13, color: primaryColor),
                            ),
                            Text(
                              "Hours",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 13, color: primaryColor),
                        ),
                        Column(
                          children: [
                            Text(
                              '15',
                              style:
                                  TextStyle(fontSize: 13, color: primaryColor),
                            ),
                            Text(
                              "Minutes",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 13, color: primaryColor),
                        ),
                        Column(
                          children: [
                            Text(
                              '12',
                              style:
                                  TextStyle(fontSize: 13, color: primaryColor),
                            ),
                            Text(
                              "Seconds",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CupertinoButton(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(13),
                        child: Text(
                          'Checkpoints',
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CheckPointScreen();
                          }));
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 57,
            ),
            CupertinoButton(
                color: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 105.w, vertical: 20),
                child: Text(
                  'Clock Out',
                  style: TextStyle(color: white, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CheckPointScreen();
                  }));
                }),
          ]),
        ),
      ),
    );
  }
}
