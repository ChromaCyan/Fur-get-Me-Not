import 'package:equatable/equatable.dart';

abstract class ChatMessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMessages extends ChatMessageEvent {
  final String otherUserId;

  FetchMessages(this.otherUserId);

  @override
  List<Object> get props => [otherUserId];
}

class SendMessage extends ChatMessageEvent {
  final String content;
  final String otherUserId;

  SendMessage(this.content, this.otherUserId);

  @override
  List<Object> get props => [content, otherUserId];
}

