import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart'; // Update this if needed
import 'package:intl/intl.dart';

class ChatAdopterCurrentUserCard extends StatelessWidget {
  final AdopterChatMessage message;
  final String profileImage;

  const ChatAdopterCurrentUserCard({
    Key? key,
    required this.message,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double messageWidth = _calculateMessageWidth(message.content);

    return Align(
      alignment: Alignment.centerRight, // Align message bubble to the right
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end, // Align to the right
          children: [
            // Message content container
            Container(
              width: messageWidth, // Dynamic width adjustment
              child: Card(
                color: const Color(0xFF21899C), // Background color for user
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10), // Inner padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message content
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100, // Minimum width for short messages
                          maxWidth: messageWidth, // Adjust for longer messages
                        ),
                        child: Text(
                          message.content,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Timestamp aligned at the bottom left
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          _formatTime(message.timestamp),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5), // Space between message and avatar
            // Profile image on the right
            // CircleAvatar(
            //   backgroundImage: NetworkImage(profileImage),
            //   radius: 20,
            // ),
          ],
        ),
      ),
    );
  }

  // Function to format timestamp into 12-hour format with AM/PM
  String _formatTime(DateTime timestamp) {
    return DateFormat('hh:mm a').format(timestamp); // Example: 02:05 PM
  }

  // Calculate message bubble width dynamically based on content length
  double _calculateMessageWidth(String content) {
    const double minWidth = 150.0; // Minimum width for short messages
    const double maxWidth = 300.0; // Maximum width for long messages
    double contentWidth =
        content.length * 7.0; // Approximate width per character

    return contentWidth.clamp(minWidth, maxWidth);
  }
}
