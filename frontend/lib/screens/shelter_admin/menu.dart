import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      backgroundColor: Colors.blueGrey[800], // Change to your preferred color
      selectedItemColor: Colors.black, // Color of the selected item
      unselectedItemColor: Colors.grey, // Color of unselected items
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Adoption List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
      ],
    );
  }
}
