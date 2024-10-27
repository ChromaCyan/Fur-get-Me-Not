import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart'; // Update if needed
import 'package:intl/intl.dart';

class ChatAdopterOtherUserCard extends StatelessWidget {
  final AdopterChatMessage message;
  final String profileImage;

  const ChatAdopterOtherUserCard({
    Key? key,
    required this.message,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double messageWidth = _calculateMessageWidth(message.content);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
              radius: 20,
            ),
            const SizedBox(width: 5), // Space between avatar and message box
            Container(
              width: messageWidth, // Dynamically adjust the width
              child: Card(
                color: Colors.grey[300],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sender's name in a fixed full-width Text widget
                      Text(
                        message.senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1, // Ensure the name doesn’t wrap
                        overflow: TextOverflow
                            .ellipsis, // Handle long names gracefully
                      ),
                      const SizedBox(height: 2),
                      // Message content and timestamp with dynamic resizing
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100, // Ensure a reasonable minimum width
                          maxWidth:
                              messageWidth, // Dynamically adjust for long messages
                        ),
                        child: Text(
                          message.content,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatTime(message.timestamp),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('hh:mm a').format(timestamp);
  }

  /// Calculate the width based on the message length.
  double _calculateMessageWidth(String content) {
    const double minWidth = 150.0; // Minimum width for short messages
    const double maxWidth = 300.0; // Maximum width for long messages
    double contentWidth =
        content.length * 7.0; // Approximate width per character

    return contentWidth.clamp(minWidth, maxWidth);
  }
}
