import 'package:fur_get_me_not/models/adoptee/chat/admin_chat_list.dart';

class AdminChatListRepository {
  static final List<Chat> _chatData = [
    Chat(
      name: 'Josie Marie',
      lastMessage: "Is Arthur the labrador still available for adoption?",
      profilePicture: 'images/images2.png',
      timestamp: DateTime.now(),
    ),
    Chat(
      name: 'Jennefer Kay',
      lastMessage: 'Can I head to your adoption shelter tommorow morning?',
      profilePicture: 'images/image1.png',
      timestamp: DateTime.now(),
    ),
  ];

  Future<List<Chat>> fetchAllChats() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _chatData;
  }

  Future<Chat> fetchChatByName(String name) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _chatData.firstWhere(
          (chat) => chat.name == name,
      orElse: () => Chat(
        name: 'Unknown',
        lastMessage: 'No message available.',
        profilePicture: 'https://example.com/default.jpg',
        timestamp: DateTime.now(),
      ),
    );
  }
}
