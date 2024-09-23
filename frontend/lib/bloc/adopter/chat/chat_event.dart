abstract class ChatEvent {}

class FetchChatMessages extends ChatEvent {
  final String userName;

  FetchChatMessages(this.userName);
}

class SendMessage extends ChatEvent {
  final String userName;
  final String message;

  SendMessage(this.userName, this.message);
}
