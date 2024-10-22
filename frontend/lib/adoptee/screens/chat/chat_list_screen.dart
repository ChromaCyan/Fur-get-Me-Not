import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_state.dart';
import 'package:fur_get_me_not/widgets/cards/admin_chat_list_card.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminChatListBloc>().add(FetchChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatListError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ChatListLoaded) {
            final chats = state.chats;

            if (chats.isEmpty) {
              return Center(
                child: Text(
                  'No chats found.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return AdminChatCard(
                        chat: chats[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Error: Unknown state'));
        },
      ),
    );
  }
}
