import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adoptee/nav_bar/nav_cubit.dart';
import 'pages.dart';

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
              ChatListScreen(),
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
                  icon: Icons.pets,
                  page: 0,
                  label: "Pet List",
                  filledIcon: Icons.pets,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.fact_check,
                  page: 1,
                  label: "Adoption Request",
                  filledIcon: Icons.fact_check,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.message_outlined,
                  page: 2,
                  label: "Chat",
                  filledIcon: Icons.message_outlined,
                ),
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
      onTap: () => _onNavItemTapped(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _selectedIndex == page ? filledIcon : icon,
            color: _selectedIndex == page ? Colors.black : Colors.red,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == page ? Colors.black : Colors.red,
              fontSize: 12,
              fontWeight: _selectedIndex == page
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
