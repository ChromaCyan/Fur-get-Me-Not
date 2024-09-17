import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/screens/pet_owner/menu.dart';
import 'package:fur_get_me_not/screens/pet_owner/pages.dart';

class AdopterHomeScreen extends StatefulWidget {
  const AdopterHomeScreen({Key? key}) : super(key: key);

  @override
  _AdopterHomeScreenState createState() => _AdopterHomeScreenState();
}

class _AdopterHomeScreenState extends State<AdopterHomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0); // Start with AdoptionScreen
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: SafeArea(  // Use SafeArea to remove the black top bar and display content under the system's status bar.
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(index);
            },
            children: [
              AdoptionScreen(),  // Initial screen for Adoption List
              ReminderScreen(),
              // Other screens
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFA54E4E),  // Maroon color background
          child: SizedBox(
            height: 30,  // Adjust height to make the nav smaller
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomNavBarItem(
                  context,
                  icon: Icons.home_outlined,
                  page: 0,
                  label: "Adopt",
                  filledIcon: Icons.home,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.notifications_outlined,
                  page: 1,
                  label: "Reminder",
                  filledIcon: Icons.notifications,
                ),
                // Add more items here if needed
              ],
            ),
          ),
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
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
        _pageController.animateToPage(page,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            context.watch<BottomNavCubit>().state == page ? filledIcon : icon,
            color: context.watch<BottomNavCubit>().state == page ? const Color(0xFFFEC107) : Colors.white,  // Yellow for selected, white for unselected
            size: 24,  // Slightly smaller icon size
          ),
          Text(
            label,
            style: TextStyle(
              color: context.watch<BottomNavCubit>().state == page ? const Color(0xFFFEC107) : Colors.white,
              fontSize: 12,  // Slightly smaller font size
              fontWeight: context.watch<BottomNavCubit>().state == page
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
