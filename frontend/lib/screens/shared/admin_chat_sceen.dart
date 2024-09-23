import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat/chat_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat/chat_event.dart';
import 'package:fur_get_me_not/bloc/adopter/chat/chat_state.dart';
import 'package:fur_get_me_not/repositories/chat_repository.dart';
import 'package:fur_get_me_not/screens/widgets/chat_bar.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  const ChatScreen({Key? key, required this.userName, required this.profileImageUrl,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        userName: userName,
        profileImageUrl: profileImageUrl,
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(context.read<ChatRepository>())
          ..add(FetchChatMessages(userName)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatMessagesLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ListTile(
                          title: Text(message.sender),
                          subtitle: Text(message.message),
                        );
                      },
                    ),
                  ),
                  // Message input field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (text) {
                              if (text.isNotEmpty) {
                                context
                                    .read<ChatBloc>()
                                    .add(SendMessage(userName, text));
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Type a message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ChatError) {
              return Center(child: Text(state.message));
            }
            return Container(); // Fallback case
          },
        ),
      ),
    );
  }
}
