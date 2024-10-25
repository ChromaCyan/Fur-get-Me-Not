import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_event.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_state.dart';
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

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages when the screen is initialized
  }

  // Fetch messages based on current chatId or otherUserId
  void _fetchMessages() {
    if (widget.chatId.isNotEmpty) {
      context.read<ChatBloc>().add(FetchMessages(widget.chatId));
    } else {
      context.read<ChatBloc>().add(FetchMessages(widget.otherUserId));
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the user has switched to a different otherUserId
    if (oldWidget.otherUserId != widget.otherUserId) {
      // Fetch messages for the new user
      _fetchMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ChatAppBar(
        userName: widget.userName,
        profileImage: widget.profileImage,
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
                _buildMessageInput(),
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
                    context.read<ChatBloc>().add(FetchMessages(widget.chatId.isNotEmpty ? widget.chatId : widget.otherUserId)); // Retry fetching messages
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: Container()),
              _buildMessageInput(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  context.read<ChatBloc>().add(
                    SendMessage(
                      text,
                      widget.chatId.isNotEmpty ? widget.chatId : widget.otherUserId,
                    ),
                  );
                  _messageController.clear();
                }
              },
              decoration: const InputDecoration(
                labelText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = _messageController.text;
              if (text.isNotEmpty) {
                context.read<ChatBloc>().add(
                  SendMessage(
                    text,
                    widget.chatId.isNotEmpty ? widget.chatId : widget.otherUserId,
                  ),
                );
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
