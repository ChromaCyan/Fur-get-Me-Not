class AdminChatList {
  final String chatId;
  final String lastMessage;
  final DateTime updatedAt;
  final String otherUserId;
  final String otherUserName;
  final String? profileImage;
  final bool isRead;

  AdminChatList({
    required this.chatId,
    required this.lastMessage,
    required this.updatedAt,
    required this.otherUserId,
    required this.otherUserName,
    this.profileImage,
    this.isRead = false,
  });

  factory AdminChatList.fromJson(Map<String, dynamic> json) {
    // Extracting otherUser directly from JSON structure
    final otherUser = json['otherUser'];
    final fullName = otherUser != null
        ? otherUser['fullName'] ?? 'Unknown User' // Default if fullName is null
        : 'Unknown User'; // Default if otherUser is null

    return AdminChatList(
      chatId: json['chatId'] as String,
      lastMessage: json['lastMessage'] as String,
      updatedAt: DateTime.parse(json['updatedAt']),
      otherUserId: otherUser?['id'] ?? 'Unknown ID',
      otherUserName: fullName,
      profileImage: otherUser?['profileImage'] ?? 'images/image2.png',
    );
  }

  get currentUserId => null;
}
