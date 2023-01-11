import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_functions.dart';
import 'package:sgt/presentation/all_team_member/all_team_member_screen.dart';
import 'package:sgt/presentation/home_screen/widgets/circular_profile_widget.dart';
import 'package:sgt/presentation/home_screen/widgets/location_details_card.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../widgets/main_appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'Greylock Security',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Team', style: CustomTheme.textField_Headertext_Style),
                //btn to see all team members
                InkWell(
                  onTap: () {
                    screenNavigator(context, AllTeamMemberScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text('See all', style: CustomTheme.seeAllBtnStyle),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 110,
              child: CircularProfile(), //showing all team member horizontally
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Jobs',
                  style: CustomTheme.textField_Headertext_Style,
                ),
                //btn to see all the active jobs
                InkWell(
                  onTap: () {
                    screenNavigator(context, JobsScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text('See all', style: CustomTheme.seeAllBtnStyle),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //location card widget
            LocationDetailsCard(),
          ]),
        ),
      ),
    );
  }
}
