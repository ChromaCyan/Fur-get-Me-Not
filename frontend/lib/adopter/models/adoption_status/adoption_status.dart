class AdoptionStatus {
  final String petName; // Extracted from the petId object
  final String ownerName; // Assuming this comes from the adopterId
  final String status;
  final String requestDate; // Adjust this to DateTime if necessary

  AdoptionStatus({
    required this.petName,
    required this.ownerName,
    required this.status,
    required this.requestDate,
  });

  factory AdoptionStatus.fromJson(Map<String, dynamic> json) {
    return AdoptionStatus(
      petName: json['petId']['name'],
      ownerName: json['adopterId'],
      status: json['status'],
      requestDate: json['requestDate'],
    );
  }
}
