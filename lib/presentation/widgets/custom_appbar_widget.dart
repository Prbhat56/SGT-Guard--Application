import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/const.dart';

// ignore: must_be_immutable
class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  CustomAppBarWidget({super.key, required this.appbarTitle, this.widgets});
  final String appbarTitle;
  List<Widget>? widgets;
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
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        appbarTitle,
        textScaleFactor: 1.0,
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
      ),
      actions: widgets,
    );
  }
}
