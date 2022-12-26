import 'package:flutter/material.dart';
import 'package:sgt/presentation/all_team_member/all_team_member_screen.dart';
import 'package:sgt/presentation/home_screen/widgets/circular_profile_widget.dart';
import 'package:sgt/presentation/home_screen/widgets/location_details_card.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/presentation/work_report_screen/work_report_screen.dart';
import 'package:sgt/utils/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        leading: Icon(
          Icons.check_circle,
          color: greenColor,
        ),
        title: Text(
          'Greylock Security',
          style: TextStyle(color: black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.map,
                color: black,
                size: 30,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WorkReportScreen(),
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const WorkReportScreen()));
                },
                icon: Icon(
                  Icons.add,
                  color: black,
                  size: 30,
                )),
          )
        ],
      ),
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
                        fontWeight: FontWeight.bold)),
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
                  child: const Text('See all > ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )),
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
                Text('Active Jobs',
                    style: TextStyle(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
                  child: const Text('See all > ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 1250,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => const LocationDetailsCard(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
