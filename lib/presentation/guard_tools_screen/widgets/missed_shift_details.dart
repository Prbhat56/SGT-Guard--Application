import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/const.dart';
import '../../map_screen/map_screen.dart';
import '../../property_details_screen/widgets/shift_cards.dart';

class MissedShiftDetailsScreen extends StatelessWidget {
  MissedShiftDetailsScreen({super.key});
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
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
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: primaryColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 195, 195, 195),
                                  offset: Offset(1.5, 1.5),
                                  blurRadius: 2.5,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.5, 1.5),
                                  blurRadius: 1.5,
                                  spreadRadius: 0.5,
                                ),
                              ]),
                          height: 300,
                          width: 500,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: currentlocation, zoom: 14)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: white,
                                border:
                                    Border.all(color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.near_me,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
