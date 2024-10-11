class AdminChatMessage {
  final String chatId;
  final String senderId;
  final String content;
  final String senderName;
  final String recipientName;
  final DateTime timestamp;

  AdminChatMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.senderName,
    required this.recipientName,
    required this.timestamp,
  });

  factory AdminChatMessage.fromJson(Map<String, dynamic> json) {
    return AdminChatMessage(
      chatId: json['chatId'],
      senderId: json['senderId'],
      content: json['content'],
      senderName: json['senderName'],
      recipientName: json['recipientName'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
