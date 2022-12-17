import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgt/presentation/account_screen/account_screen.dart';
import 'package:sgt/presentation/connect_screen/connect_screen.dart';
import 'package:sgt/presentation/notification_screen/notification_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/time_sheet_screen.dart';
import 'package:sgt/utils/const.dart';
import 'home_screen/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> currentWidget = [
    const HomeScreen(),
    const TimeSheetScreen(),
    const ConnectScreen(),
    const NotificationScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go close the app?',
                    textScaleFactor: 1.0),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.only(
                        top: 6,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "No",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.only(
                        top: 6,
                        left: 8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "Yes",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            body: currentWidget[_selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.black,
                //     blurRadius: 10,
                //   ),
                //],
              ),
              child: BottomNavigationBar(
                elevation: 20,
                currentIndex: _selectedIndex,
                selectedItemColor: primaryColor,
                selectedLabelStyle:
                    TextStyle(color: primaryColor, fontSize: 13),
                type: BottomNavigationBarType.fixed,
                onTap: (index) => setState(() {
                  _selectedIndex = index;
                }),
                items: [
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.home,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.home,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.receipt_long_rounded,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.receipt_long_rounded,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Time Sheet',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: FaIcon(
                      FontAwesomeIcons.solidComment,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const FaIcon(
                      FontAwesomeIcons.solidComment,
                      size: 28,
                      color: Colors.grey,
                    ),
                    // icon: const Icon(
                    //   Icons.message_rounded,
                    //   size: 28,
                    //   color: Colors.grey,
                    // ),
                    label: 'Connect',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.notifications,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.person,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
