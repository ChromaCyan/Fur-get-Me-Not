import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat_list.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';
import 'package:fur_get_me_not/adoptee/screens/chat/admin_chat_sceen.dart';

class AdminChatCard extends StatelessWidget {
  final AdminChatList chat;

  const AdminChatCard({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/placeholder.png'),
        ),
        title: Text(chat.otherUserName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(chat.lastMessage),
        trailing: Text(
          _formatTimestamp(chat.updatedAt),
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                userName: chat.otherUserName,
                profileImageUrl: 'images/image1.png',
                chatId: chat.chatId,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
  }
}
