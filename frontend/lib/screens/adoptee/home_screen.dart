import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'pages.dart';

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
          backgroundColor: const Color(0xFFF5E6CA),
          title: Text(
            'Fur-get Me Not',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(index);
            },
            children: [
              //AdoptionScreen(),
              //ReminderScreen(),
              // Other screens
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFA54E4E),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomNavBarItem(
                  context,
                  icon: Icons.home_outlined,
                  page: 0,
                  label: "Pets List",
                  filledIcon: Icons.home,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.fact_check,
                  page: 1,
                  label: "Status",
                  filledIcon: Icons.fact_check,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.message_outlined,
                  page: 2,
                  label: "Chat",
                  filledIcon: Icons.message_outlined,
                ),
                _bottomNavBarItem(
                  context,
                  icon: Icons.person,
                  page: 3,
                  label: "Profile",
                  filledIcon: Icons.person,
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
