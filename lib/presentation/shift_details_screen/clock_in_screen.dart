import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: greenColor,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isClockedIn
                      ? const Text(
                          'Clocked In!',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          'Clocked Out!',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    isClockedIn
                        ? 'You are currently clocked in and ready to go! '
                        : 'Thank you for your service and security. ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    // height: 350,
                    width: 311,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: Column(children: [
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
                        height: 16,
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
                        height: 10,
                      ),
                      const Text(
                        'Greylock Security',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Property',
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Rivi Properties',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Guard Post Duties',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Time:',
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor),
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
                        height: 5,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Shift:',
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor),
                            ),
                            const Text(
                              ' 10:00 AM - 04:00 PM',
                              style: TextStyle(
                                fontSize: 15,
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
                          color: Colors.grey,
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
                                style: TextStyle(
                                    fontSize: 15, color: primaryColor),
                              ),
                              Text(
                                "Hours",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          Column(
                            children: [
                              Text(
                                '15',
                                style: TextStyle(
                                    fontSize: 15, color: primaryColor),
                              ),
                              Text(
                                "Minutes",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          Column(
                            children: [
                              Text(
                                '12',
                                style: TextStyle(
                                    fontSize: 15, color: primaryColor),
                              ),
                              Text(
                                "Seconds",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CupertinoButton(
                      color: seconderyColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 20),
                      child: Text(
                        'Back',
                        style: TextStyle(color: primaryColor, fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 105.w, vertical: 20),
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
                ]),
          ),
        ),
      ),
    );
  }
}
