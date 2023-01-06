import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/const.dart';

class UpcomingShiftDetailsScreen extends StatelessWidget {
  const UpcomingShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
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
            title: Text(
              'Shift details',
              style: TextStyle(color: black),
            )),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start at:',
                style: TextStyle(color: primaryColor),
              ),
              Text(
                'Monday, October 24',
                style: TextStyle(color: black, fontSize: 17),
              ),
              Text(
                '10:00 AM ~ 4:00 PM',
                style: TextStyle(color: black),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guard',
                        style: TextStyle(color: primaryColor),
                      ),
                      Text(
                        'Matheus Paolo',
                        style: TextStyle(color: black, fontSize: 17),
                      ),
                      Text(
                        'Executive Protection',
                        style: TextStyle(color: black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: grey,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Property',
                style: TextStyle(color: primaryColor),
              ),
              Text(
                'Rivi Properties',
                style: TextStyle(color: black, fontSize: 17),
              ),
              Text(
                'Guard Post Duties',
                style: TextStyle(color: black),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Job Details',
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire comprehensam et nec. Dico facilisis ut has, quo homero nostro menandri id. Graeco nusquam splendide et vim.',
                  style: TextStyle(color: black),
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
              // Center(
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         'Start at:',
              //         style: TextStyle(
              //             color: primaryColor, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         '6/20/22,',
              //         style: TextStyle(
              //             color: primaryColor, fontWeight: FontWeight.bold),
              //       ),
              //       Text(
              //         '07:30 AM',
              //         style: TextStyle(
              //           color: primaryColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
