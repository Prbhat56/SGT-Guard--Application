import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/const.dart';
import '../../map_screen/map_screen.dart';
import '../../property_details_screen/widgets/shift_cards.dart';
import '../../shift_details_screen/shift_details_sceen.dart';

class MissedShiftDetailsScreen extends StatelessWidget {
  const MissedShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: grey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: grey,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      color: grey,
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Rivi Properties',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '1517 South Centelella',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '43 Bourke Street, Newbridge NSW 837\nRaffles Place, Boat Band M83',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Missed Shift',
                    style: TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ShiftCards(shiftdate: '6/20/22', shifttime: '07:30 AM'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
