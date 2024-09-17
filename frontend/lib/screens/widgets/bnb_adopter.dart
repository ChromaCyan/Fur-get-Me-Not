import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/screens/pet_owner/menu.dart';
import 'package:fur_get_me_not/screens/pet_owner/pages.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// Top Level Pages
  final List<Widget> topLevelPages = [
    AdoptionScreen(),
    ReminderScreen(),
  ];

  /// on Page Changed
  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(), // Provide the Cubit
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 2, 2),
        appBar: _menuAppBar(),
        body: _menuBody(),
        bottomNavigationBar: _menuBottomNavBar(context),
      ),
    );
  }

  // Bottom Navigation Bar - Menu Widget
  BottomAppBar _menuBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.home_outlined,
                  page: 0,
                  label: "Home",
                  filledIcon: Icons.home,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.pets_outlined,
                  page: 1,
                  label: "Favorite",
                  filledIcon: Icons.pets,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.notifications_outlined,
                  page: 2,
                  label: "Notifs",
                  filledIcon: Icons.notifications,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.chat_outlined,
                  page: 3,
                  label: "Profile",
                  filledIcon: Icons.chat,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 80,
            height: 20,
          ),
        ],
      ),
    );
  }

  // App Bar - Menu Widget
  AppBar _menuAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text("BottomNavigationBar with Cubit"),
    );
  }

  // Body - Menu Widget
  PageView _menuBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelPages,
    );
  }

  // Bottom Navigation Bar Single item - Menu Widget
  Widget _bottomAppBarItem(
      BuildContext context, {
        required IconData defaultIcon,
        required int page,
        required String label,
        required IconData filledIcon,
      }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 300), // Adjusted duration
            curve: Curves.easeInOut);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color: context.watch<BottomNavCubit>().state == page
                  ? Colors.amber
                  : Colors.grey,
              size: 26,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: TextStyle(
                color: context.watch<BottomNavCubit>().state == page
                    ? Colors.amber
                    : Colors.grey,
                fontSize: 13,
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
