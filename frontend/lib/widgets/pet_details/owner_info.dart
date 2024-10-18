import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/screens/chat/chat_screen.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_event.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_state.dart';

class OwnerInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final String profileImageUrl;
  final String? chatId;
  final String otherUserId;
  final String initialMessage; // Allow for a customizable message

  const OwnerInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profileImageUrl,
    this.chatId,
    required this.otherUserId,
    this.initialMessage = "Hi! Let's chat!",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building OwnerInfo for: $firstName $lastName');
    print('ChatId: $chatId, OtherUserId: $otherUserId');

    return BlocListener<ChatBloc, ChatMessageState>(
      listener: (context, state) {
        if (state is ChatMessageSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chatId: state.chatId,
                userName: '$firstName $lastName',
                profileImageUrl: profileImageUrl,
              ),
            ),
          );
        } else if (state is ChatMessageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating new chat: ${state.message}')),
          );
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: gender == 'Male' ? Colors.blue : Colors.pink,
            backgroundImage: AssetImage(profileImageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print('Chat button tapped. chatId: $chatId, otherUserId: $otherUserId');

              if (chatId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      chatId: chatId!,
                      userName: '$firstName $lastName',
                      profileImageUrl: profileImageUrl,
                    ),
                  ),
                );
              } else {
                context.read<ChatBloc>().add(SendMessage(initialMessage, otherUserId));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.chat_outlined,
                color: Colors.lightBlue,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
