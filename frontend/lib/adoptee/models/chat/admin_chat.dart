class AdminChatMessage {
  final String chatId;
  final String senderId;
  final String content;
  final String senderName;
  final String recipientName;
  final DateTime timestamp;
  bool isUnread;

  AdminChatMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.senderName,
    required this.recipientName,
    required this.timestamp,
    this.isUnread = true,
  });

  factory AdminChatMessage.fromJson(Map<String, dynamic> json) {
    return AdminChatMessage(
      chatId: json['chatId'] as String,
      // Extracting the senderId from the nested object
      senderId: (json['senderId'] is Map) ? json['senderId']['_id'] as String : json['senderId'] as String,
      content: json['content'] as String,
      senderName: json['senderName'] as String,
      recipientName: json['recipientName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isUnread: true,
    );
  }
}
