import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/presentation/all_team_member/all_team_member_screen.dart';
import 'package:sgt/presentation/home_screen/widgets/circular_profile_widget.dart';
import 'package:sgt/presentation/home_screen/widgets/location_details_card.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/utils/const.dart';
import '../widgets/main_appbar_widget.dart';
import 'widgets/location_details_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'Greylock Security',
      ),
      // appBar: AppBar(
      //   toolbarHeight: 48,
      //   shadowColor: Color.fromARGB(255, 186, 185, 185),
      //   elevation: 6,
      //   backgroundColor: white,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(
      //       left: 12.0,
      //     ),
      //     child: Icon(
      //       Icons.check_circle,
      //       color: greenColor,
      //     ),
      //   ),
      //   leadingWidth: 30,
      //   title: Text(
      //     'Greylock Security',
      //     style: TextStyle(color: black, fontWeight: FontWeight.w400),
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         Navigator.of(context).push(
      //           PageRouteBuilder(
      //             transitionDuration: const Duration(milliseconds: 500),
      //             pageBuilder: (context, animation, secondaryAnimation) =>
      //                 const GuardToolScreen(),
      //             transitionsBuilder:
      //                 (context, animation, secondaryAnimation, child) {
      //               return SlideTransition(
      //                 position: Tween<Offset>(
      //                         begin: const Offset(1, 0), end: Offset.zero)
      //                     .animate(animation),
      //                 child: child,
      //               );
      //             },
      //           ),
      //         );
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 15.0),
      //         child: SvgPicture.asset('assets/tool.svg'),
      //       ),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Team',
                    style: TextStyle(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AllTeamMemberScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1, 0), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: const Text('See all',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 110,
              child: CircularProfile(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Jobs',
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const JobsScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1, 0), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: const Text('See all',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // color: Colors.amber,
              height: 290 * locationData.length.toDouble(),
              child: ListView.builder(
                itemCount: locationData.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => LocationDetailsCard(
                  title: locationData[index].title,
                  subtitle: locationData[index].subtitle,
                  imageUrl: locationData[index].imageUrl,
                  duty: locationData[index].duty,
                  address: locationData[index].address,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
