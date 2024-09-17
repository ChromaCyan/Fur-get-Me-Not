class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime reminderDate;
  final bool repeat;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderDate,
    required this.repeat,
  });

  // Factory constructor to create a Reminder from JSON
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      reminderDate: DateTime.parse(json['reminderDate']),
      repeat: json['repeat'],
    );
  }

  // Method to convert a Reminder to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reminderDate': reminderDate.toIso8601String(),
      'repeat': repeat,
    };
  }
}
