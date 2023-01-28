import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/widgets/map_card_widget.dart';
import '../../property_details_screen/widgets/shift_cards.dart';
import '../../widgets/custom_text_widget.dart';

class MissedShiftDetailsScreen extends StatefulWidget {
  MissedShiftDetailsScreen({super.key});

  @override
  State<MissedShiftDetailsScreen> createState() =>
      _MissedShiftDetailsScreenState();
}

class _MissedShiftDetailsScreenState extends State<MissedShiftDetailsScreen> {
  LatLng currentlocation = const LatLng(22.572645, 88.363892);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'Missed Shifts'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rivi Properties',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          const Text(
                            '1517 South Centelella',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Last Shift:',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' October 24, 10:00 AM ~ 4:00 PM',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Divider(
                    color: CustomTheme.primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldHeaderWidget(title: 'Missed Shift'),
                  const SizedBox(height: 10),
                  Container(
                    height: 48,
                    width: 122,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: seconderyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shiftCardsData[0].shiftdate,
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          shiftCardsData[0].shifttime,
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFieldHeaderWidget(title: 'Description'),
                  const SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFieldHeaderWidget(title: 'Location'),
                  const SizedBox(height: 10),
                  const Text(
                    '43 Bourke Street, Newbridge NSW 837\nRaffles Place, Boat Band M83',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 25),
                  MapCardWidget(), //showing map card
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
