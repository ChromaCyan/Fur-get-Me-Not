import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_state.dart';
import 'package:fur_get_me_not/widgets/navigations/chat_bar.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String profileImageUrl;
  final String chatId; // Add this line

  const ChatScreen({
    Key? key,
    required this.userName,
    required this.profileImageUrl,
    required this.chatId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        userName: widget.userName,
        profileImageUrl: widget.profileImageUrl,
      ),
      body: BlocProvider(
        create: (context) => AdminChatBloc(context.read<AdminChatRepository>())
          ..add(FetchMessages(widget.chatId)), // Use chatId to fetch messages
        child: BlocBuilder<AdminChatBloc, ChatMessageState>(
          builder: (context, state) {
            if (state is ChatMessageLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatMessageLoaded) {
              // Scroll to the bottom when messages are loaded
              _scrollToBottom();

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true, // This makes new messages appear at the bottom
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[state.messages.length - 1 - index]; // Reverse the order
                        return ListTile(
                          title: Text(message.senderName),
                          subtitle: Text(message.content),
                          trailing: Text(
                            "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}", // Ensure minutes are padded
                            style: const TextStyle(fontSize: 12),
                          ),
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
                                context.read<AdminChatBloc>().add(SendMessage(text, widget.userName));
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
            } else if (state is ChatMessageError) {
              return Center(child: Text(state.message));
            }
            return Container(); // Fallback case
          },
        ),
      ),
    );
  }
}
