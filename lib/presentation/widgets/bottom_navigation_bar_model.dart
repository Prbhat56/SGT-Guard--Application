import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomNavigationBarItemModel {
  final IconData icon;
  final String label;
  BottomNavigationBarItemModel({
    required this.icon,
    required this.label,
  });
}

List<BottomNavigationBarItemModel> bottmNavigationItemData = [
  BottomNavigationBarItemModel(icon: Icons.home, label: "Home".tr),
  BottomNavigationBarItemModel(
      icon: Icons.receipt_long_rounded, label: "timesheet".tr),
  BottomNavigationBarItemModel(
      icon: FontAwesomeIcons.solidComment, label: 'connect'.tr),
  BottomNavigationBarItemModel(
      icon: Icons.notifications, label: 'notification'.tr),
  BottomNavigationBarItemModel(icon: Icons.person, label: 'account'.tr)
];
