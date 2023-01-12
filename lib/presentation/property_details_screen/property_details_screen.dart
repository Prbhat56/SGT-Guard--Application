import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/widgets/shift_cards.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import '../../utils/const.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import '../qr_screen/scanning_screen.dart';
import '../widgets/custom_text_widget.dart';
import 'widgets/custom_icons_widget.dart';
import 'widgets/job_details_widget.dart';
import 'widgets/map_card_widget.dart';
import 'widgets/property_description_widget.dart';
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
              PropertyDetailsWidget(), //widget to create top property detials card
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
                    SizedBox(height: 20),
                    Divider(color: primaryColor),
                    const SizedBox(height: 20),
                    TextFieldHeaderWidget(title: 'Upcoming Shifts'),
                    const SizedBox(height: 10),
                    ShiftCards(), //shift cards widget
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldHeaderWidget(title: 'Job Details'),
                        const SizedBox(height: 10),
                        JobDetailsWidget(), //widgets to show job details
                        const SizedBox(height: 25),
                        TextFieldHeaderWidget(title: 'Description'),
                        const SizedBox(height: 10),
                        PropertyDescriptionWidget(), //widget to show property details
                        const SizedBox(height: 25),
                        TextFieldHeaderWidget(title: 'Location'),
                        const SizedBox(height: 10),
                        const Text(
                          '43 Bourke Street, Newbridge NSW 837\nRaffles Place, Boat Band M83',
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 20),
                        MapCardWidget(), //showing map card
                        const SizedBox(height: 30),
                        Center(
                            child: CustomButtonWidget(
                                buttonTitle: 'Start Shift',
                                onBtnPress: () {
                                  //logic to start the timer if it's not start
                                  context.read<TimerOnCubit>().state.istimerOn
                                      ? null
                                      : context
                                          .read<TimerOnCubit>()
                                          .turnOnTimer();
                                  screenNavigator(context, ScanningScreen());
                                })),
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
