import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat_list.dart';
import 'package:fur_get_me_not/adopter/screens/chat/chat_screen.dart';

class ChatCard extends StatelessWidget {
  final AdopterChatList chat;

  const ChatCard({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFE9879), // Use your secondary color for a warm feel
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: ListTile(
        leading: CircleAvatar(
          // Use the profileImage URL or a placeholder if null
          backgroundImage: chat.profileImage != null && chat.profileImage!.isNotEmpty
              ? NetworkImage(chat.profileImage!)
              : AssetImage('assets/images/placeholder.png') as ImageProvider,
        ),
        title: Text(
          chat.otherUserName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          chat.lastMessage,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          _formatTimestamp(chat.updatedAt),
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                userName: chat.otherUserName,
                profileImage: chat.profileImage ?? 'images/images2.png',
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
