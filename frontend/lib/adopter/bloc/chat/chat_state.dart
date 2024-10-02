import 'package:fur_get_me_not/adopter/repositories/chat/chat_repository.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatMessagesLoaded(this.messages);
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
