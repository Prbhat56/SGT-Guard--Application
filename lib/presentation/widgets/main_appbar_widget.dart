import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import '../../utils/const.dart';
import '../guard_tools_screen/guard_tools_screen.dart';
import '../settings_screen/settings_screen.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(49);
  const MainAppBarWidget({
    super.key,
    required this.appBarTitle,
  });
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        toolbarHeight: 48,
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
          appBarTitle,
          style: TextStyle(color: black, fontWeight: FontWeight.w400),
        ),
        actions: [
          appBarTitle == 'Account'
              ? IconButton(
                  onPressed: () {
                    screenNavigator(context, SettingsScreen());
                  },
                  icon: Icon(
                    Icons.settings_rounded,
                    color: primaryColor,
                  ),
                )
              : InkWell(
                  onTap: () {
                    screenNavigator(context, GuardToolScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SvgPicture.asset('assets/tool.svg'),
                  ),
                ),
        ],
      ),
    );
  }
}
