import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/shift_details_screen/check_in%20_error_screen.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    height: 350,
                    width: 311,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Matheus Paolo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: black,
                        ),
                      ),
                      const Text(
                        'Greylock Security',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Date & Time',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Monday, October 24',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '10:00 AM',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Property',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const Text(
                        'Rivi Properties',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Guard Post Duties',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CupertinoButton(
                      color: grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 20),
                      child: Text(
                        'Back',
                        style: TextStyle(color: black, fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CheckInErrorScreen();
                        }));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 123, vertical: 20),
                      child: Text(
                        isClockedIn ? 'Clock Out' : 'Clock In',
                        style: TextStyle(color: white, fontSize: 17),
                      ),
                      onPressed: () {
                        setState(() {
                          isClockedIn = !isClockedIn;
                        });
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
