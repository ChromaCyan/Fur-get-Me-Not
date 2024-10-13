class AdopterChatMessage {
  final String chatId;
  final String senderId;
  final String content;
  final String senderName;
  final String recipientName;
  final DateTime timestamp;

  AdopterChatMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.senderName,
    required this.recipientName,
    required this.timestamp,
  });

  factory AdopterChatMessage.fromJson(Map<String, dynamic> json) {
    return AdopterChatMessage(
      chatId: json['chatId'],
      senderId: json['senderId']['_id'],
      content: json['content'],
      senderName: json['senderName'],
      recipientName: json['recipientName'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
