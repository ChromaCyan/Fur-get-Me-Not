import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';

class AdopteeHomeScreen extends StatefulWidget {
  const AdopteeHomeScreen({Key? key}) : super(key: key);

  @override
  _AdopteeHomeScreenState createState() => _AdopteeHomeScreenState();
}

class _AdopteeHomeScreenState extends State<AdopteeHomeScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;
  int _adoptionRequestCount = 0;
  int _chatNotificationCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Load adoption requests and chats when the screen initializes
    context.read<AdoptionRequestBloc>().add(LoadAdoptionRequests());
    _fetchChatListCount();
  }

  // Fetch chat list count
  Future<void> _fetchChatListCount() async {
    final adminChatRepository = AdminChatRepository();
    final chatBloc = AdminChatListBloc(adminChatRepository);
    chatBloc.add(FetchChats());

    final state = await chatBloc.stream.firstWhere(
          (s) => s is ChatListLoaded,
    );

    if (state is ChatListLoaded) {
      setState(() {
        _chatNotificationCount = state.chatlistCount;
      });
    }
  }

  // Handle navigation item taps
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Reset the local chat unread count when navigating to chat
        _chatNotificationCount = 0;
      }
      if (index == 2) {
        // Clear unread request IDs and reset the unread count when viewing requests
        _adoptionRequestCount = 0;
      }
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Check if a given request is unread (i.e., pending)
  bool isUnread(AdoptionRequest request) {
    return request.requestStatus.toLowerCase() == "pending";
  }

  // Define _getDynamicTitle to change the title based on the selected index
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
          backgroundColor: const Color(0xFF21899C),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 28.0,
          ),
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getDynamicTitle(),
              key: ValueKey<int>(_selectedIndex),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        drawer: AdopteeDrawer(), // Drawer for navigation
        body: SafeArea(
          child: BlocListener<AdoptionRequestBloc, AdoptionRequestState>(
            listener: (context, state) {
              if (state is AdoptionRequestLoaded) {
                // Track unread requests locally
                List<String> unreadRequestIds = state.requests
                    .where((request) => isUnread(request))
                    .map((request) => request.requestId)
                    .toList();
                setState(() {
                  _adoptionRequestCount = unreadRequestIds.length;
                });
              }
            },
            child: PageView(
              controller: _pageController,
              children: [
                PetManagementScreen(), // Screen for managing listed pets
                ChatListScreen(), // Chat list screen
                AdoptionRequestListScreen(),
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
