import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/const.dart';

class CheckInErrorScreen extends StatelessWidget {
  const CheckInErrorScreen({super.key});

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
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ERROR',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'You are not in your designated location to begin your shift ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                      onPressed: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 123, vertical: 20),
                      child: Text(
                        'Clock Out',
                        style: TextStyle(color: white, fontSize: 17),
                      ),
                      onPressed: () {}),
                ]),
          ),
        ),
      ),
    );
  }
}
