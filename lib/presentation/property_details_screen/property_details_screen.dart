import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/map_screen/map_screen.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_media_preview_screen.dart';
import 'package:sgt/presentation/property_details_screen/widgets/shift_cards.dart';
import 'package:sgt/presentation/shift_details_screen/clock_in_screen.dart';
import '../../utils/const.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import '../qr_screen/qr_screen.dart';
import '../shift_details_screen/shift_details_sceen.dart';
import '../time_sheet_screen/check_point_screen.dart';
import '../work_report_screen/submit_report_screen.dart';
import 'check_points_list.dart';
import 'cubit/showmore/showmore_cubit.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            color: grey,
                            child: Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                  ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  left: 60,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: greenColor,
                                      border:
                                          Border.all(color: white, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Rivi Properties',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '1517 South Centelella',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '15',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Guards',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: const [
                                Text(
                                  '10',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Points',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: const [
                                Text(
                                  '70000',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Sqft',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const QrScreen()));
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.grey)),
                                child: SvgPicture.asset(
                                  'assets/qr.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Text(
                              'Scan QR',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckPointListsScreen()));
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(Icons.map, color: primaryColor),
                              ),
                            ),
                            Text(
                              'Checkpoints',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SubmitReportScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                                begin: const Offset(1, 0),
                                                end: Offset.zero)
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(Icons.add, color: primaryColor),
                              ),
                            ),
                            Text(
                              'Report',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Job Details',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Gaurd Name:',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                        Text(
                          ' Matheus Paolo',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Position:',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                        Text(
                          ' Superviser',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shift Time:',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                        Text(
                          ' 10:00 AM - 04:00 PM',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire ',
                            // softWrap: true,
                            maxLines:
                                context.watch<ShowmoreCubit>().state.showmore
                                    ? 10
                                    : 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        context.watch<ShowmoreCubit>().state.showmore
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  context.read<ShowmoreCubit>().showMore();
                                  print(context
                                      .read<ShowmoreCubit>()
                                      .state
                                      .showmore);
                                },
                                child: Text(
                                  'more',
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                ),
                              )
                      ],
                    ),
                    context.watch<ShowmoreCubit>().state.showmore
                        ? SizedBox(
                            height: 90,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                    height: 88,
                                    width: 122,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                    height: 88,
                                    width: 122,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                        height: 88,
                                        width: 122,
                                      ),
                                      Opacity(
                                        opacity: 0.5,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PropertyMediaPreviewScreen()));
                                          },
                                          child: Container(
                                            height: 85,
                                            width: 122,
                                            color: Colors.black,
                                            child: Center(
                                              child: Text('+2',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Upcoming Shifts',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ShiftCards(
                                shiftdate: '6/20/22', shifttime: '07:30 AM'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ShiftCards(
                                shiftdate: '7/08/22', shifttime: '09:30 AM'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ShiftCards(
                                shiftdate: '9/14/22', shifttime: '10:30 AM'),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                      ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    CupertinoButton(
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 20),
                        child: Text(
                          'Start Shift',
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                        onPressed: () {
                          context.read<TimerOnCubit>().turnOnTimer();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClockInScreen()));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
