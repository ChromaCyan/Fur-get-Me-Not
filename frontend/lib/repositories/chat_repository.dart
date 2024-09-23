import 'package:fur_get_me_not/models/chat.dart';

class ChatRepository {
  final List<ChatMessage> _messages = [
    ChatMessage(sender: 'Josh Brian Bugarin', message: 'Is Arthur still available for adoption?', timestamp: DateTime.now().subtract(Duration(minutes: 2))),
    ChatMessage(sender: 'Sophia Black', message: 'Yes, she is still available for adoption!', timestamp: DateTime.now().subtract(Duration(minutes: 1))),
  ];

  Future<List<ChatMessage>> fetchMessages(String userName) async {
    await Future.delayed(Duration(seconds: 1));
    return _messages.where((msg) => msg.sender == userName || msg.sender == 'Josh Brian Bugarin').toList();
  }

  void sendMessage(String sender, String message) {
    _messages.add(ChatMessage(
      sender: sender,
      message: message,
      timestamp: DateTime.now(),
    ));
  }
}
