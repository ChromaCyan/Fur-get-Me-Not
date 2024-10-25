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

// Update the SendMessage event
class SendMessage extends ChatMessageEvent {
  final String content;
  final String otherUserId;
  final String senderId;
  final String senderName; // Add this line

  SendMessage(this.content, this.otherUserId, this.senderId,
      this.senderName); // Update constructor

  @override
  List<Object> get props =>
      [content, otherUserId, senderId, senderName]; // Update props
}
