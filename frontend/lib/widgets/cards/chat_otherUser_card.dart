import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';
import 'package:intl/intl.dart'; // Import intl package

class ChatOtherUserCard extends StatelessWidget {
  final AdminChatMessage message;
  final String profileImage;

  const ChatOtherUserCard({
    Key? key,
    required this.message,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double messageWidth = _calculateMessageWidth(message.content);

    return Align(
      alignment: Alignment.centerLeft, // Align message to the left
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
              radius: 20, // Avatar size
            ),
            const SizedBox(width: 5), // Space between avatar and message box
            Container(
              width: messageWidth, // Adjust width dynamically
              child: Card(
                color: Colors.grey[300], // Background color for other user
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align left
                    children: [
                      // Display sender's name with fixed layout behavior
                      Text(
                        message.senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1, // Ensure name does not wrap
                        overflow: TextOverflow.ellipsis, // Handle long names
                      ),
                      const SizedBox(height: 2),
                      // Message content with constrained width
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100, // Minimum width for short messages
                          maxWidth: messageWidth, // Adjust for long messages
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
                      // Align timestamp to the bottom right
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatTime(message.timestamp), // Formatted time
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

  // Format time to 12-hour format with AM/PM
  String _formatTime(DateTime timestamp) {
    return DateFormat('hh:mm a').format(timestamp); // Example: 02:05 PM
  }

  // Calculate message width dynamically based on content length
  double _calculateMessageWidth(String content) {
    const double minWidth = 150.0; // Minimum width for short messages
    const double maxWidth = 285.0; // Maximum width for long messages
    double contentWidth =
        content.length * 7.0; // Approximate width per character

    return contentWidth.clamp(minWidth, maxWidth);
  }
}
