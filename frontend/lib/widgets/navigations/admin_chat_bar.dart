import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String profileImageUrl; // Path to the asset image

  const ChatAppBar({
    Key? key,
    required this.userName,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          // Using NetworkImage if the profileImageUrl is a URL
          CircleAvatar(
            backgroundImage: profileImageUrl.isNotEmpty
                ? (profileImageUrl.startsWith('http')
                ? NetworkImage(profileImageUrl)
                : AssetImage(profileImageUrl) as ImageProvider)
                : const AssetImage('assets/default_avatar.png'), // Default avatar if URL is empty
          ),
          const SizedBox(width: 10),
          Expanded( // Use Expanded to avoid overflow issues
            child: Text(
              userName,
              overflow: TextOverflow.ellipsis, // Truncate if too long
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous screen
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
