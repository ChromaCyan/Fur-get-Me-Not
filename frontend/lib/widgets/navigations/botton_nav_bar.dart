import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.home_outlined, size: 30, color: Colors.white),
        Icon(Icons.pets, size: 30, color: Colors.white),
        Icon(Icons.message_outlined, size: 30, color: Colors.white),
        Icon(Icons.fact_check, size: 30, color: Colors.white),
      ],
      index: selectedIndex,
      color: const Color(0xFF21899C),
      buttonBackgroundColor: Color(0xFFFE9879),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        onItemTapped(index);
      },
      letIndexChange: (index) => true,
    );
  }
}
