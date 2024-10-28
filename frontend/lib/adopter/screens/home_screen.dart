import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_event.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_state.dart';
import 'package:fur_get_me_not/adopter/screens/pages.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_state.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_status/adoption_status_repository.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
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
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  int _adoptionStatusCount = 0;
  int _messageCount = 0;

  // Handle tab selection changes
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 2) {
        _messageCount = 0;
      }

      if (index == 3) {
        _adoptionStatusCount = 0;
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
    _pageController = PageController(initialPage: 0);
    _fetchAdoptionStatusCount();
    _fetchChatListCount();
  }

  Future<void> _fetchAdoptionStatusCount() async {
    final bloc = AdoptionStatusBloc(
      adoptionStatusRepository: AdoptionStatusRepository(),
    );
    bloc.add(LoadAdoptionStatus());

    final state = await bloc.stream.firstWhere(
          (s) => s is AdoptionStatusLoaded,
    );

    if (state is AdoptionStatusLoaded) {
      setState(() {
        _adoptionStatusCount = state.statusCount;
      });
    }
  }

  Future<void> _fetchChatListCount() async {
    final adminChatRepository = AdminChatRepository();

    final chatBloc = AdminChatListBloc(adminChatRepository);

    chatBloc.add(FetchChats());

    final state = await chatBloc.stream.firstWhere(
          (s) => s is ChatListLoaded,
    );

    if (state is ChatListLoaded) {
      setState(() {
        _messageCount = state.unreadCount;
      });
    }
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
          backgroundColor: const Color(0xFF21899C),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 28.0,
          ),
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getDynamicTitle(context),
              key: ValueKey<int>(_selectedIndex),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(index);
            },
            children: [
              AdoptionScreen(),
              PetListScreen(),
              ChatListScreen(),
              AdoptionStatusScreen(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          messageBadgeCount: _messageCount, // Pass the message count
          adoptionStatusBadgeCount: _adoptionStatusCount,
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
        return 'My Adopted Pets';
      case 2:
        return 'Chat';
      case 3:
        return 'Adoption Status';
      default:
        return 'Home';
    }
  }
}
