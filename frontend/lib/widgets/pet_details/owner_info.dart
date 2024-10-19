import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/screens/chat/chat_screen.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class OwnerInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final String profileImageUrl;
  final String? chatId;
  final String otherUserId;

  const OwnerInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profileImageUrl,
    this.chatId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () async {
            final repository = AdopterChatRepository();

            if (chatId != null) {
              // Load existing chat
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
              try {
                final newChatId = await repository.sendMessage(
                    'Hi! Let\'s chat!', otherUserId);

                // Navigate to the new chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      chatId: newChatId,
                      userName: '$firstName $lastName',
                      profileImageUrl: profileImageUrl,
                    ),
                  ),
                );
              } catch (error) {
                // Handle error gracefully
                print('Error creating new chat: $error');
              }
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
    );
  }
}
