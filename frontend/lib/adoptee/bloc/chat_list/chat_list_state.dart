import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat_list.dart';

abstract class ChatListState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<AdminChatList> chats;

  ChatListLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class ChatListError extends ChatListState {
  final String message;

  ChatListError(this.message);

  @override
  List<Object> get props => [message];
}
