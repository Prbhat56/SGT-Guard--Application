import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/presentation/settings_screen/settings_screen.dart';
import '../../utils/const.dart';
import '../guard_tools_screen/guard_tools_screen.dart';
import '../widgets/main_appbar_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(appBarTitle: 'Account'),
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
      //     'Account',
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
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           PageRouteBuilder(
      //             transitionDuration: const Duration(milliseconds: 500),
      //             pageBuilder: (context, animation, secondaryAnimation) =>
      //                 const SettingsScreen(),
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
      //       icon: Icon(
      //         Icons.settings_outlined,
      //         color: black,
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: white,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: grey,
                    backgroundImage: const NetworkImage(
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    ),
                  ),
                ),
                Text(
                  'Personal',
                  style: TextStyle(color: black, fontSize: 17),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Name',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: 'Jenny Doe',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: 'johndoe@mail.com',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Phone',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: '(808)628 8343',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Address',
                  style: TextStyle(color: black, fontSize: 17),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Street',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: 'Sample Street',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'City',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: 'Los Angeles',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'State',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: 'CA',
                      focusColor: primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Zipcode',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      hintText: '90045',
                      focusColor: primaryColor),
                ),
                // const SizedBox(
                //   height: 40,
                // ),
                // Center(
                //   child: CupertinoButton(
                //       disabledColor: seconderyColor,
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 90.w, vertical: 15),
                //       color: primaryColor,
                //       child: Text(
                //         'Update Profile',
                //         style: TextStyle(fontSize: 15.sp),
                //       ),
                //       onPressed: () {}),
                // ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
