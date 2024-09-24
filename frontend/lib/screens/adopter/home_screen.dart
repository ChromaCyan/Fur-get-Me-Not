import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/screens/adopter/reminder/reminder_screen.dart';
import 'package:fur_get_me_not/screens/adopter/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/screens/adopter/pages.dart';
import 'adoption_status/adoption_status.dart';
import 'package:fur_get_me_not/widgets/navigations/botton_nav_bar.dart';

class AdopterHomeScreen extends StatefulWidget {
  @override
  _AdopterHomeScreenState createState() => _AdopterHomeScreenState();
}

class _AdopterHomeScreenState extends State<AdopterHomeScreen> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
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
              ChatListScreen(),
              AdoptionStatusScreen(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onTabSelected,
        ),
      ),
    );
  }

  String _getDynamicTitle(BuildContext context) {
    switch (_selectedIndex) {
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
}
