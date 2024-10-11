import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';

abstract class ChatMessageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatMessageInitial extends ChatMessageState {}

class ChatMessageLoading extends ChatMessageState {}

class ChatMessageLoaded extends ChatMessageState {
  final List<AdminChatMessage> messages;

  ChatMessageLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatMessageError extends ChatMessageState {
  final String message;

  ChatMessageError(this.message);

  @override
  List<Object> get props => [message];
}
