import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/screens/pet_owner/reminder_screen.dart';
import 'package:fur_get_me_not/screens/pet_owner/pet_details_screen.dart';
import 'package:fur_get_me_not/screens/shared/chat_screen.dart';
import 'package:fur_get_me_not/screens/pet_owner/pages.dart';
import 'adoption_status.dart';

class AdopterHomeScreen extends StatefulWidget {
  final Widget? initialPage;

  const AdopterHomeScreen({Key? key, this.initialPage}) : super(key: key);

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

  void _navigateToChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            _getDynamicTitle(context),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {
                // Navigate to Profile Screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(index);
            },
            children: [
              AdoptionScreen(),
              ReminderScreen(),
              AdoptionScreen(),
              ChatScreen(),
              AdoptionStatusScreen(),
              // Other screens
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
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
        ),
      ),
    );
  }

  String _getDynamicTitle(BuildContext context) {
    switch (context.watch<BottomNavCubit>().state) {
      case 0:
        return 'Adopt a pet';
      case 1:
        return 'Reminders';
      case 2:
        return 'My Adopted Pet List';
      case 3:
        return 'Chat';
      case 4:
        return 'Adoption Status';
      default:
        return 'Home';
    }
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
            color: context.watch<BottomNavCubit>().state == page ? Colors.black : Colors.red,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: context.watch<BottomNavCubit>().state == page ? Colors.black : Colors.red,
              fontSize: 12,
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
