import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_in_screen.dart';
import '../../utils/const.dart';

class ShiftDetailsScreen extends StatelessWidget {
  const ShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Shift details',
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
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ),
          ],
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '10:00 AM ~ 4:00 PM',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Guard',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Matheus Paolo',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Executive Protection',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Property',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rivi Properties',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Guard Post Duties',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Job Details',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire comprehensam et nec. Dico facilisis ut has, quo homero nostro menandri id. Graeco nusquam splendide et vim.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                CupertinoButton(
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 20),
                    child: Text(
                      'Clock In',
                      style: TextStyle(color: white, fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ClockInScreen();
                      }));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
