import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat_list.dart';
import 'package:fur_get_me_not/adoptee/screens/chat/admin_chat_sceen.dart';
import 'package:fur_get_me_not/adoptee/screens/chat/admin_chat_sceen.dart';

class AdminChatCard extends StatelessWidget {
  final AdminChatList chat;

  const AdminChatCard({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFE9879), // Use a warm color for a cozy feel
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for softness
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/placeholder.png'), // Placeholder image for profile
        ),
        title: Text(
          chat.otherUserName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for contrast
          ),
        ),
        subtitle: Text(
          chat.lastMessage,
          style: const TextStyle(color: Colors.white70), // Light grey for the subtitle
        ),
        trailing: Text(
          _formatTimestamp(chat.updatedAt),
          style: const TextStyle(color: Colors.white70), // Light grey for the timestamp
        ),
        onTap: () {
          print('Navigating to chat with User ID: ${chat.otherUserId}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                userName: chat.otherUserName,
                profileImageUrl: 'images/image1.png',
                chatId: chat.otherUserId,
                otherUserId: chat.otherUserId,
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
