import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat_list.dart';
import 'package:fur_get_me_not/adoptee/screens/chat/admin_chat_sceen.dart';
import 'package:fur_get_me_not/helpers/storage_helper.dart';

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
          backgroundImage:
              chat.profileImage != null && chat.profileImage!.isNotEmpty
                  ? NetworkImage(
                      chat.profileImage!) // Use NetworkImage for valid URLs
                  : const AssetImage('assets/images/placeholder.png')
                      as ImageProvider, // Use placeholder image otherwise
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
          style: const TextStyle(
            color: Colors.white70, // Light grey for the subtitle
          ),
        ),
        trailing: Text(
          _formatTimestamp(chat.updatedAt),
          style: const TextStyle(
            color: Colors.white70, // Light grey for the timestamp
          ),
        ),
        onTap: () async {
          // Retrieve the current user ID from storage
          final currentUserId = await StorageHelper.getUserId();

          if (currentUserId != null) {
            print('Navigating to chat with User ID: ${chat.otherUserId}');

            // Navigate to the ChatScreen with the correct user IDs
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userName: chat.otherUserName,
                  profileImage: chat.profileImage ?? 'images/image1.png',
                  chatId: chat.chatId, // Ensure the correct chatId is passed
                  otherUserId: chat.otherUserId,
                  currentUserId: currentUserId, // Pass the actual user ID
                ),
              ),
            );
          } else {
            print('Error: No current user ID found!');
            // Optionally, show an alert or prompt the user to log in
          }
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
  }
}
