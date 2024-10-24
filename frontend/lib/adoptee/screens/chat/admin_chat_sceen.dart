import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_state.dart';
import 'package:fur_get_me_not/widgets/navigations/chat_bar.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String profileImage;
  final String chatId;
  final String otherUserId;

  const ChatScreen({
    Key? key,
    required this.userName,
    required this.profileImage,
    required this.chatId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _hasViewedChat = false; // Track if the chat has been viewed

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _markMessagesAsRead(List<AdminChatMessage> messages) {
    for (var message in messages) {
      if (message.senderId != widget.otherUserId) {
        message.isUnread = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminChatBloc>(context).add(FetchMessages(widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        userName: widget.userName,
        profileImage: widget.profileImage,
      ),
      body: BlocBuilder<AdminChatBloc, ChatMessageState>(
        builder: (context, state) {
          if (state is ChatMessageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatMessageLoaded) {
            if (!_hasViewedChat) {
              _markMessagesAsRead(state.messages);
              _hasViewedChat = true;
            }
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
                              context.read<AdminChatBloc>().add(SendMessage(text, widget.otherUserId));
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
                    context.read<AdminChatBloc>().add(FetchMessages(widget.otherUserId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}