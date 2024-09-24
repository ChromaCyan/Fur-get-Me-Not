// lib/models/adoption_request.dart

class AdoptionRequest {
  final String id;
  final String petName;
  final String ownerName;
  final DateTime adoptionDate;
  final String status;

  AdoptionRequest({
    required this.id,
    required this.petName,
    required this.ownerName,
    required this.adoptionDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_name': petName,
      'owner_name': ownerName,
      'adoption_date': adoptionDate.toIso8601String(),
      'status': status,
    };
  }

  factory AdoptionRequest.fromJson(Map<String, dynamic> json) {
    return AdoptionRequest(
      id: json['id'],
      petName: json['pet_name'] ?? '',
      ownerName: json['owner_name'] ?? '',
      adoptionDate: DateTime.parse(json['adoption_date']),
      status: json['status'] ?? '',
    );
  }
}
