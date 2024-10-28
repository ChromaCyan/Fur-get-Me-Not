import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_state.dart';
import 'package:fur_get_me_not/adopter/screens/pages.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_status/adoption_status_repository.dart';
import 'adoption_status/adoption_status.dart';
import 'package:fur_get_me_not/widgets/navigations/botton_nav_bar.dart';
import 'package:fur_get_me_not/widgets/navigations/drawer.dart';

class AdopterHomeScreen extends StatefulWidget {
  const AdopterHomeScreen({Key? key}) : super(key: key);

  @override
  _AdopterHomeScreenState createState() => _AdopterHomeScreenState();
}

class _AdopterHomeScreenState extends State<AdopterHomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final FlutterSecureStorage _storage =
      FlutterSecureStorage();
  int _adoptionStatusCount = 0;

  // Handle tab selection changes
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 3) { // Assuming 3 is the index for AdoptionStatusScreen
        _adoptionStatusCount = 0; // Reset the badge count
      }

      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the page controller with the first page
    _pageController = PageController(initialPage: 0);
    _fetchAdoptionStatusCount();
  }

  Future<void> _fetchAdoptionStatusCount() async {
    // Create a bloc instance and load adoption statuses
    final bloc = AdoptionStatusBloc(
      adoptionStatusRepository: AdoptionStatusRepository(),
    );
    bloc.add(LoadAdoptionStatus());

    // Listen for the loaded state
    final state = await bloc.stream.firstWhere(
          (s) => s is AdoptionStatusLoaded,
    );

    if (state is AdoptionStatusLoaded) {
      setState(() {
        _adoptionStatusCount = state.statusCount;
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the page controller to free resources
    _pageController.dispose();
    super.dispose();
  }

  // Define the main widget structure
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BottomNavCubit(), // Provide the nav bar state management cubit
      child: Scaffold(
        appBar: AppBar(
          elevation: 0, // Remove shadow under the AppBar
          backgroundColor: const Color(0xFF21899C),

          // Customize the hamburger menu icon (drawer icon)
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the icon color to match the theme
            size: 28.0, // Optional: Customize the size of the icon
          ),

          // Dynamic title for the AppBar
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getDynamicTitle(
                  context), // Get the title based on the selected index
              key: ValueKey<int>(
                  _selectedIndex), // Use the index as the key for switching animations
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        drawer: AppDrawer(), // Drawer navigation for the app

        // Safe area to handle screen insets
        body: SafeArea(
          child: PageView(
            controller:
                _pageController, // Control the page view with the PageController
            onPageChanged: (index) {
              // Update the selected index when the page changes
              BlocProvider.of<BottomNavCubit>(context)
                  .changeSelectedIndex(index);
            },
            children: [
              AdoptionScreen(),
              PetListScreen(),
              ChatListScreen(),
              AdoptionStatusScreen(),
            ],
          ),
        ),

        // Custom bottom navigation bar
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          adoptionStatusBadgeCount: _adoptionStatusCount,
          onItemTapped: _onTabSelected,
        ),
      ),
    );
  }

  // Determine the dynamic title based on the current page index
  String _getDynamicTitle(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return 'Adopt a pet'; // Title for adoption screen
      case 1:
        return 'My Adopted Pets'; // Title for pet list screen
      case 2:
        return 'Chat'; // Title for chat screen
      case 3:
        return 'Adoption Status'; // Title for adoption status screen
      default:
        return 'Home'; // Default title
    }
  }
}
