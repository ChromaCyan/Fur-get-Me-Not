class Chat {
  final String name;
  final String lastMessage;
  final String profilePicture;
  final DateTime timestamp;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.profilePicture,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'profilePicture': profilePicture,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      name: json['name'],
      lastMessage: json['lastMessage'],
      profilePicture: json['profilePicture'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
