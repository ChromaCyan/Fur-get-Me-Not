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
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Adopter Home"),
        ),
        body: PageView(
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
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
              // Add more items here
            ],
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
            color: context.watch<BottomNavCubit>().state == page ? Colors.amber : Colors.grey,
            size: 26,
          ),
          Text(
            label,
            style: TextStyle(
              color: context.watch<BottomNavCubit>().state == page ? Colors.amber : Colors.grey,
              fontSize: 13,
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
