class AdminChatList {
  final String chatId;
  final String lastMessage;
  final DateTime updatedAt;
  final String otherUserName;

  AdminChatList({
    required this.chatId,
    required this.lastMessage,
    required this.updatedAt,
    required this.otherUserName,
  });

  factory AdminChatList.fromJson(Map<String, dynamic> json) {
    return AdminChatList(
      chatId: json['chatId'],
      lastMessage: json['lastMessage'],
      updatedAt: DateTime.parse(json['updatedAt']),
      otherUserName: json['otherUser']['firstName'] + ' ' + json['otherUser']['lastName'],
    );
  }
}
