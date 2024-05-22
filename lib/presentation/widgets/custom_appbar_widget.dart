import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/theme/font_style.dart';
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
      shadowColor: Color.fromARGB(255, 186, 185, 185),
      elevation: 6,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: false,
      titleSpacing: 0,
      title: Align(
        alignment: Alignment(-0.92.w, 0),
        child: Text(
          appbarTitle,
          textScaleFactor: 1.0,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      actions: widgets,
    );
  }
}
