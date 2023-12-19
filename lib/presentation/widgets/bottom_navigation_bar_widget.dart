import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/const.dart';
import '../cubit/navigation/navigation_cubit.dart';
import 'bottom_navigation_bar_model.dart';

class BottomNavigationBarItemList extends StatefulWidget {
  const BottomNavigationBarItemList({super.key});

  @override
  State<BottomNavigationBarItemList> createState() =>
      _BottomNavigationBarItemListState();
}

class _BottomNavigationBarItemListState
    extends State<BottomNavigationBarItemList> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      context.read<NavigationCubit>().changeIndex(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: seconderyColor),
      ),
      child: BottomNavigationBar(
          elevation: 20,
          currentIndex:
              _selectedIndex, //context.watch<NavigationCubit>().state.selectedIndex,
          selectedItemColor: primaryColor,
          selectedLabelStyle: TextStyle(color: primaryColor, fontSize: 12),
          type: BottomNavigationBarType.fixed,
          // onTap: (index) => context.read<NavigationCubit>().changeIndex(index),
          onTap: _onItemTapped,
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
