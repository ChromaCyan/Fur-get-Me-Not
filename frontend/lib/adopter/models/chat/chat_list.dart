class AdopterChatList {
  final String chatId;
  final String lastMessage;
  final DateTime updatedAt;
  final String otherUserName;

  AdopterChatList({
    required this.chatId,
    required this.lastMessage,
    required this.updatedAt,
    required this.otherUserName,
  });

  factory AdopterChatList.fromJson(Map<String, dynamic> json) {
    return AdopterChatList(
      chatId: json['chatId'],
      lastMessage: json['lastMessage'],
      updatedAt: DateTime.parse(json['updatedAt']),
      otherUserName: json['otherUser']['firstName'] + ' ' + json['otherUser']['lastName'],
    );
  }
}
