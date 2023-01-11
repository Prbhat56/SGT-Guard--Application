import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/map_screen/map_screen.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_media_preview_screen.dart';
import 'package:sgt/presentation/property_details_screen/widgets/shift_cards.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import '../qr_screen/qr_screen.dart';
import '../work_report_screen/work_report_screen.dart';
import 'check_points_list.dart';
import 'cubit/showmore/showmore_cubit.dart';
import 'widgets/custom_icons_widget.dart';
import 'widgets/property_details_widget.dart';

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
        appBar: CustomAppBarWidget(appbarTitle: 'Property Detail'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: seconderyLightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    PropertyDetailsWidget(), //widget to create top property detials card
                    SizedBox(
                      height: 33,
                    ),
                    Center(
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
                                '7000',
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
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //mapping the customIconsData list
                        //to show all the icons
                        children: customIconsData
                            .map((e) => CustomIconWidget(
                                  iconUrl: e.iconUrl,
                                  title: e.title,
                                ))
                            .toList()),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Upcoming Shifts',
                      style: CustomTheme.textField_Headertext_Style,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ShiftCards(), //shift cards widget
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job Details',
                          style: CustomTheme.textField_Headertext_Style,
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
                                  fontWeight: FontWeight.w300,
                                  color: black),
                            ),
                            Text(
                              ' Matheus Paolo',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontWeight: FontWeight.w300,
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
                                  fontWeight: FontWeight.w300,
                                  color: black),
                            ),
                            Text(
                              ' Superviser',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontWeight: FontWeight.w300,
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
                                  fontWeight: FontWeight.w300,
                                  color: black),
                            ),
                            Text(
                              ' 10:00 AM - 04:00 PM',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Description',
                          style: CustomTheme.textField_Headertext_Style,
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
                                maxLines: context
                                        .watch<ShowmoreCubit>()
                                        .state
                                        .showmore
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PropertyMediaPreviewScreen()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.5),
                                        child: Image.network(
                                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                          height: 88,
                                          width: 122,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PropertyMediaPreviewScreen()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.5),
                                        child: Image.network(
                                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                          height: 88,
                                          width: 122,
                                        ),
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
                          height: 25,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    boxShadow: CustomTheme.mapCardShadow),
                                height: 231,
                                width: 339.w,
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
                                          builder: (context) =>
                                              const MapScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          color: primaryColor, width: 2),
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
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 300.w,
                            child: CupertinoButton(
                                color: primaryColor,
                                child: Text(
                                  'Start Shift',
                                  style: TextStyle(color: white, fontSize: 17),
                                ),
                                onPressed: () {
                                  context.read<TimerOnCubit>().state.istimerOn
                                      ? null
                                      : context
                                          .read<TimerOnCubit>()
                                          .turnOnTimer();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QrScreen()));
                                }),
                          ),
                        ),
                      ],
                    ),
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
