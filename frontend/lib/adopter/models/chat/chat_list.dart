class AdopterChatList {
  final String chatId;
  final String lastMessage;
  final DateTime updatedAt;
  final String otherUserId;
  final String otherUserName;
  final String? profileImage;

  AdopterChatList({
    required this.chatId,
    required this.lastMessage,
    required this.updatedAt,
    required this.otherUserId,
    required this.otherUserName,
    this.profileImage,
  });

  factory AdopterChatList.fromJson(Map<String, dynamic> json) {
    final otherUser = json['otherUser'];
    final fullName = otherUser != null
        ? otherUser['fullName'] ?? 'Unknown User'
        : 'Unknown User';

    return AdopterChatList(
      chatId: json['chatId'] as String,
      lastMessage: json['lastMessage'] as String,
      updatedAt: DateTime.parse(json['updatedAt']),
      otherUserId: otherUser?['id'] ?? 'Unknown ID',
      otherUserName: fullName,
      profileImage: otherUser?['profileImage'] ?? 'images/image2.png',
    );
  }
}
