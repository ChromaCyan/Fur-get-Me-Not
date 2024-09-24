import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/admin_chat_list.dart';
import 'package:fur_get_me_not/screens/shared/admin_chat_sceen.dart';

class AdminChatCard extends StatelessWidget {
  final Chat chat;

  const AdminChatCard({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.profilePicture),
        ),
        title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(chat.lastMessage),
        trailing: Text(
          _formatTimestamp(chat.timestamp),
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                userName: chat.name,
                profileImageUrl: chat.profilePicture,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed
    return "${timestamp.hour}:${timestamp.minute}";
  }
}
