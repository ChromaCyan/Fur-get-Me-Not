import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_state.dart';
import 'package:fur_get_me_not/widgets/cards/admin_chat_list_card.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dispatch the FetchChats event when the screen is built
    context.read<AdminChatListBloc>().add(FetchChats());

    return Scaffold(
      body: BlocBuilder<AdminChatListBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ChatLoaded) {
            final chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return AdminChatCard(chat: chats[index]);
              },
            );
          }
          return const Center(child: Text('No chats available.'));
        },
      ),
    );
  }
}
