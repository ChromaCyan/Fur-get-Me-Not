import 'package:fur_get_me_not/models/chat_list.dart';

class ChatListRepository {
  static final List<Chat> _chatData = [
    Chat(
      name: 'Janine Kristina',
      lastMessage: "Yes, she is still available for adoption!",
      profilePicture: 'images/image3.png',
      timestamp: DateTime.now(),
    ),
    Chat(
      name: 'Jane Smith',
      lastMessage: 'What time will you pick her up in the shelter?',
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
