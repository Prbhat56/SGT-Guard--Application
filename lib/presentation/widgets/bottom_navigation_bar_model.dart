import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/const.dart';
import '../cubit/navigation/navigation_cubit.dart';

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

class BottomNavigationBarItemList extends StatelessWidget {
  const BottomNavigationBarItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: seconderyColor),
      ),
      child: BottomNavigationBar(
          elevation: 20,
          currentIndex: context.watch<NavigationCubit>().state.selectedIndex,
          selectedItemColor: primaryColor,
          selectedLabelStyle: TextStyle(color: primaryColor, fontSize: 13),
          type: BottomNavigationBarType.fixed,
          onTap: (index) => context.read<NavigationCubit>().changeIndex(index),
          items: bottmNavigationItemData.map((e) {
            return BottomNavigationBarItem(
              activeIcon: e.label == 'Connect'
                  ? FaIcon(
                      e.icon,
                      size: 28,
                      color: primaryColor,
                    )
                  : Icon(
                      e.icon,
                      size: 28,
                      color: primaryColor,
                    ),
              icon: Icon(
                e.icon,
                size: 28,
                color: Colors.grey,
              ),
              label: e.label,
            );
          }).toList()),
    );
  }
}
