import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adoptee/screens/pages.dart';
import 'package:fur_get_me_not/widgets/navigations/adoptee_bottom_nav_bar.dart';

class AdopteeHomeScreen extends StatefulWidget {
  const AdopteeHomeScreen({Key? key}) : super(key: key);

  @override
  _AdopteeHomeScreenState createState() => _AdopteeHomeScreenState();
}

class _AdopteeHomeScreenState extends State<AdopteeHomeScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

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

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  String _getDynamicTitle(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return 'My pets listed';
      case 1:
        return 'Adoption Requests';
      case 2:
        return 'Chat';
      default:
        return 'Home';
    }
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
            children: [
              PetManagementScreen(),
              AdoptionRequestListScreen(),
              ChatListScreen(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavItemTapped,
        ),
      ),
    );
  }
}
