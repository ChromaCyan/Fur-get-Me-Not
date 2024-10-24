import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';

class ChatCurrentUserCard extends StatelessWidget {
  final AdminChatMessage message;

  const ChatCurrentUserCard({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.zero,
          ),
        ),
        child: _buildMessageContent(),
      ),
    );
  }

  Widget _buildMessageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          message.senderName,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(
          message.content,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 5),
        Text(
          "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
