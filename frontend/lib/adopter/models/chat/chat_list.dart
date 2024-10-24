class AdopterChatList {
  final String chatId;
  final String lastMessage;
  final DateTime updatedAt;
  final String otherUserId; // Changed to store user ID
  final String otherUserName; // Keep full name as before
  final String? profileImage; // Add profileImage field

  AdopterChatList({
    required this.chatId,
    required this.lastMessage,
    required this.updatedAt,
    required this.otherUserId,
    required this.otherUserName,
    this.profileImage, // Include it in the constructor
  });

  factory AdopterChatList.fromJson(Map<String, dynamic> json) {
    // Extracting otherUser directly from JSON structure
    final otherUser = json['otherUser'];
    final fullName = otherUser != null
        ? otherUser['fullName'] ?? 'Unknown User' // Default if fullName is null
        : 'Unknown User'; // Default if otherUser is null
    final profileImage = otherUser != null ? otherUser['profileImage'] : null; // Extract profileImage

    return AdopterChatList(
      chatId: json['chatId'] as String,
      lastMessage: json['lastMessage'] as String,
      updatedAt: DateTime.parse(json['updatedAt']),
      otherUserId: otherUser?['id'] ?? 'Unknown ID', // Default if ID is null
      otherUserName: fullName,
      profileImage: profileImage, // Include profileImage in the constructor
    );
  }
}
