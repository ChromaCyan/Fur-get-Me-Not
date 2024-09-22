import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  // Sample chat data
  final List<Map<String, String>> chats = [
    {'name': 'Sophia Black', 'lastMessage': 'See you soon!'},
    {'name': 'John Doe', 'lastMessage': 'Can we reschedule?'},
    {'name': 'Alice Smith', 'lastMessage': 'I adopted a new pet!'},
    // Add more chat entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chats[index]['name']!),
            subtitle: Text(chats[index]['lastMessage']!),
            onTap: () {
              // Navigate to chat screen with selected user
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(userName: chats[index]['name']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Example ChatScreen for displaying chat with a specific user
class ChatScreen extends StatelessWidget {
  final String userName;

  const ChatScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $userName'),
      ),
      body: Center(
        child: Text('Chat messages will go here.'),
      ),
    );
  }
}
