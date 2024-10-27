class AdoptionHistory {
  final String adoptionRequestId;
  final String petId;
  final String petName;
  final String adopterId;
  final String adopterName;
  final String adopteeId;
  final String adopteeName;
  final DateTime adoptionDate;
  final String status;

  AdoptionHistory({
    required this.adoptionRequestId,
    required this.petId,
    required this.petName,
    required this.adopterId,
    required this.adopterName,
    required this.adopteeId,
    required this.adopteeName,
    required this.adoptionDate,
    required this.status,
  });

  factory AdoptionHistory.fromJson(Map<String, dynamic> json) {
    return AdoptionHistory(
      adoptionRequestId: json['adoptionRequestId'] as String,
      petId: json['petId']['_id'] as String,
      petName: json['petId']['name'] as String,
      adopterId: json['adopterId']['_id'] as String,
      adopterName: json['adopterId']['firstName'] + ' ' + json['adopterId']['lastName'],
      adopteeId: json['adopteeId']['_id'] as String, // Accessing nested adopteeId
      adopteeName: json['adopteeId']['firstName'] + ' ' + json['adopteeId']['lastName'],
      adoptionDate: DateTime.parse(json['adoptionDate']),
      status: json['status'] ?? 'Completed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adoptionRequestId': adoptionRequestId,
      'petId': petId,
      'petName': petName,
      'adopterId': adopterId,
      'adopterName': adopterName,
      'adopteeId': adopteeId,
      'adopteeName': adopteeName,
      'adoptionDate': adoptionDate.toIso8601String(),
      'status': status,
    };
  }
}
