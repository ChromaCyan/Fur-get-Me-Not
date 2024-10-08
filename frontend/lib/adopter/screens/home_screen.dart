import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adopter/screens/reminder/reminder_screen.dart';
import 'package:fur_get_me_not/adopter/screens/adoption_list/pet_details_screen.dart';
import 'package:fur_get_me_not/adopter/screens/pages.dart';
import 'adoption_status/adoption_status.dart';
import 'package:fur_get_me_not/widgets/navigations/botton_nav_bar.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';

class AdopterHomeScreen extends StatefulWidget {
  @override
  _AdopterHomeScreenState createState() => _AdopterHomeScreenState();
}

class _AdopterHomeScreenState extends State<AdopterHomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

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

  // Logout function
  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'jwt'); // Remove JWT token from secure storage
    // Navigate to the LoginScreen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Wrap in MaterialPageRoute
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
              icon: Icon(Icons.logout, color: Colors.black), // Use logout icon
              onPressed: () async {
                await _logout(context); // Call logout function
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
              PetListScreen(),
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
        return 'My Adopted Pets';
      case 3:
        return 'Chat';
      case 4:
        return 'Adoption Status';
      default:
        return 'Home';
    }
  }
}
