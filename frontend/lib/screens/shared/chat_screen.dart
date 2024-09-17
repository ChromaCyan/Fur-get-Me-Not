import 'package:flutter/material.dart';
import 'package:fur_get_me_not/screens/pet_owner/menu.dart';
import 'package:fur_get_me_not/screens/pet_owner/home_screen.dart';
import 'package:fur_get_me_not/screens/pet_owner/adoption_list.dart';
import 'package:fur_get_me_not/screens/pet_owner/reminder_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'other', 'text': "No problem! We'll get tabby ready for your adoption and remove her from listing after you adopted her!"},
    {'sender': 'user', 'text': 'Can I pick her up at your adoption center at 9pm'},
    {'sender': 'other', 'text': 'Oh yes she still is available for adoption'},
    {'sender': 'user', 'text': 'Hi there! is meowmere the tabby cat still available'},
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': _messageController.text});
        _messageController.clear();
      });
    }
  }

  int selectedIndex = 3;

  final List<Widget> _pages = [
    //HomePage(),
    AdoptionScreen(),
    //ReminderScreen(),
    ChatScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Scroll to the bottom of the conversation
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByMe = message['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSentByMe ? Colors.blue[200] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: isSentByMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
