import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/presentation/jobs_screen/widgets/active_jobs.dart';
import 'package:sgt/presentation/jobs_screen/widgets/inactive_jobs.dart';

import '../../utils/const.dart';
import '../guard_tools_screen/guard_tools_screen.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 186, 185, 185),
          elevation: 6,
          backgroundColor: white,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Icon(
              Icons.check_circle,
              color: greenColor,
            ),
          ),
          leadingWidth: 30,
          title: Text(
            'Greylock Security',
            style: TextStyle(color: black, fontWeight: FontWeight.w400),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const GuardToolScreen(),
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
                padding: const EdgeInsets.only(right: 15.0),
                child: SvgPicture.asset('assets/tool.svg'),
              ),
            )
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 2,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      icon: Text(
                        'Active',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Inactive',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 700,
                  child: TabBarView(children: [
                    ActiveJobsTab(),
                    InactiveJobsTab(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
