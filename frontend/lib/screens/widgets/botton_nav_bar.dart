import 'package:flutter/material.dart';

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
    return BottomAppBar(
      color: const Color(0xFFF5E6CA),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomNavBarItem(
              context,
              icon: Icons.home_outlined,
              page: 0,
              label: "Home",
              filledIcon: Icons.home,
            ),
            _bottomNavBarItem(
              context,
              icon: Icons.notifications_outlined,
              page: 1,
              label: "Reminder",
              filledIcon: Icons.notifications,
            ),
            _bottomNavBarItem(
              context,
              icon: Icons.pets,
              page: 2,
              label: "Pet",
              filledIcon: Icons.pets,
            ),
            _bottomNavBarItem(
              context,
              icon: Icons.message_outlined,
              page: 3,
              label: "Chat",
              filledIcon: Icons.message_outlined,
            ),
            _bottomNavBarItem(
              context,
              icon: Icons.fact_check,
              page: 4,
              label: "Status",
              filledIcon: Icons.fact_check,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavBarItem(
      BuildContext context, {
        required IconData icon,
        required int page,
        required String label,
        required IconData filledIcon,
      }) {
    return GestureDetector(
      onTap: () => onItemTapped(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selectedIndex == page ? filledIcon : icon,
            color: selectedIndex == page ? Colors.black : Colors.red,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == page ? Colors.black : Colors.red,
              fontSize: 12,
              fontWeight: selectedIndex == page
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
