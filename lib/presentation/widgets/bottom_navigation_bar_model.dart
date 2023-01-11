import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarItemModel {
  final IconData icon;
  final String label;
  BottomNavigationBarItemModel({
    required this.icon,
    required this.label,
  });
}

List<BottomNavigationBarItemModel> bottmNavigationItemData = [
  BottomNavigationBarItemModel(icon: Icons.home, label: "Home"),
  BottomNavigationBarItemModel(
      icon: Icons.receipt_long_rounded, label: "Time Sheet"),
  BottomNavigationBarItemModel(
      icon: FontAwesomeIcons.solidComment, label: 'Connect'),
  BottomNavigationBarItemModel(
      icon: Icons.notifications, label: 'Notifications'),
  BottomNavigationBarItemModel(icon: Icons.person, label: 'Account')
];
