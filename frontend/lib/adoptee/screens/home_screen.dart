import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_state.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_state.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/adoptee/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adoptee/screens/pages.dart';
import 'package:fur_get_me_not/widgets/navigations/adoptee_bottom_nav_bar.dart';
import 'package:fur_get_me_not/widgets/navigations/adoptee_drawer.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';

class AdopteeHomeScreen extends StatefulWidget {
  const AdopteeHomeScreen({Key? key}) : super(key: key);

  @override
  _AdopteeHomeScreenState createState() => _AdopteeHomeScreenState();
}

class _AdopteeHomeScreenState extends State<AdopteeHomeScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;
  int _adoptionRequestCount = 0; // Local unread count for adoption requests
  int _chatNotificationCount = 0; // Local unread count for chats
  List<String> _unreadRequestIds = [];

  bool isUnread(AdoptionRequest request) {
    return request.requestStatus.toLowerCase() == "pending";
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Load adoption requests and chats when the screen initializes
    context.read<AdoptionRequestBloc>().add(LoadAdoptionRequests());
    context.read<AdminChatListBloc>().add(FetchChats());
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) { // When navigating to chat
        _chatNotificationCount = 0; // Reset the local chat unread count
      }
      if (index == 2) { // When navigating to adoption requests
        _unreadRequestIds.clear();  // Clear the local unread request IDs
        _adoptionRequestCount = 0;   // Reset the unread request count
      }
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  // Define _getDynamicTitle to change title based on the selected index
  String _getDynamicTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'My Pets Listed';
      case 1:
        return 'Chat';
      case 2:
        return 'Adoption Requests';
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
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getDynamicTitle(),
              key: ValueKey<int>(_selectedIndex),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        drawer: AdopteeDrawer(),
        body: SafeArea(
          child: BlocListener<AdoptionRequestBloc, AdoptionRequestState>( // Listener for adoption requests
            listener: (context, state) {
              if (state is AdoptionRequestLoaded) {
                // Track unread requests locally
                List<String> unreadRequestIds = state.requests
                    .where((request) => isUnread(request))
                    .map((request) => request.requestId)
                    .toList();
                setState(() {
                  _adoptionRequestCount = unreadRequestIds.length;
                  _unreadRequestIds = unreadRequestIds;
                });
              }
            },
            child: PageView(
              controller: _pageController,
              children: [
                PetManagementScreen(),
                ChatListScreen(),
                AdoptionRequestListScreen(
                  onRequestCountUpdated: (count, unreadRequestIds) {
                    setState(() {
                      _adoptionRequestCount = unreadRequestIds.length;
                      _unreadRequestIds = unreadRequestIds;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavItemTapped,
          notificationCount: _adoptionRequestCount,
          chatNotificationCount: _chatNotificationCount,
        ),
      ),
    );
  }
}
