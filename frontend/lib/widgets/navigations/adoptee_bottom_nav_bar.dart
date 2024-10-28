import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final int notificationCount;
  final int chatNotificationCount;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.notificationCount = 0,
    this.chatNotificationCount = 0,
  }) : super(key: key);

  // Badge widget for overlaying notifications
  Widget _buildBadge(int count) {
    return count > 0
        ? Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        constraints: BoxConstraints(
          minWidth: 18,
          minHeight: 18,
        ),
        child: Center(
          child: Text(
            '$count',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.pets, size: 30, color: Colors.white),

        // Messages icon with badge overlay
        Stack(
          children: [
            Icon(Icons.message_outlined, size: 30, color: Colors.white),
            _buildBadge(chatNotificationCount), // Use the badge method here
          ],
        ),

        // Adoption Status icon with badge overlay
        Stack(
          children: [
            Icon(Icons.fact_check, size: 30, color: Colors.white),
            _buildBadge(notificationCount), // Use the badge method here
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
