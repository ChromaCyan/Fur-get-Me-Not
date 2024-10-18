import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_event.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_state.dart';
import 'package:fur_get_me_not/widgets/navigations/chat_bar.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String profileImageUrl;
  final String chatId;

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
  final TextEditingController _messageController = TextEditingController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.chatId.isNotEmpty) {
      context.read<ChatBloc>().add(FetchMessages(widget.chatId));
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        userName: widget.userName,
        profileImageUrl: widget.profileImageUrl,
      ),
      body: BlocBuilder<ChatBloc, ChatMessageState>(
        builder: (context, state) {
          if (state is ChatMessageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatMessageLoaded) {
            _scrollToBottom();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[state.messages.length - 1 - index];
                      return ListTile(
                        title: Text(
                          message.senderName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        subtitle: Text(
                          message.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                          "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                          controller: _messageController,
                          onSubmitted: (text) {
                            if (text.isNotEmpty) {
                              context.read<ChatBloc>().add(SendMessage(text, widget.chatId)); // Use chatId here
                              _messageController.clear();
                            }
                          },
                          decoration: const InputDecoration(
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 10),
                Text(
                  'Oops! Something went wrong: ${state.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ChatBloc>().add(FetchMessages(widget.chatId)); // Retry fetching messages
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return Container(); // Fallback case
        },
      ),
    );
  }
}
