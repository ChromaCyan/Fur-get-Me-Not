import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final int notificationCount; // For adoption requests
  final int chatNotificationCount; // For chat notifications

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.notificationCount = 0,
    this.chatNotificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.pets, size: 30, color: Colors.white),
        Icon(Icons.message_outlined, size: 30, color: Colors.white),
        Stack(
          children: [
            Icon(Icons.fact_check, size: 30, color: Colors.white),
            if (notificationCount > 0)
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                  child: Text(
                    '$notificationCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (chatNotificationCount > 0) // For chat notifications
              Positioned(
                top: 5,
                right: 40,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                  child: Text(
                    '$chatNotificationCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
      index: selectedIndex,
      color: const Color(0xFF21899C),
      buttonBackgroundColor: const Color(0xFFFE9879),
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
