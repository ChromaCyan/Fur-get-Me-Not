import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/screens/chat/chat_screen.dart';

class OwnerInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final String profileImageUrl;

  const OwnerInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profileImageUrl,
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userName: '$firstName $lastName',
                  profileImageUrl: profileImageUrl,
                ),
              ),
            );
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
