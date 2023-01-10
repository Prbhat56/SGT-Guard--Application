import 'package:flutter/material.dart';
import '../../utils/const.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key, required this.appbarTitle});
  final String appbarTitle;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        appbarTitle,
        textScaleFactor: 1.0,
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
