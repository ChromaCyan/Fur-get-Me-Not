class AdoptionRequest {
  final String requestId; // Add requestId
  final String adopterName; // This will now concatenate first and last names
  final String petName;
  String requestStatus;
  final String requestDate;

  AdoptionRequest({
    required this.requestId, // Include requestId in the constructor
    required this.adopterName,
    required this.petName,
    this.requestStatus = 'Pending', // Default value for status
    required this.requestDate,
  });

  factory AdoptionRequest.fromJson(Map<String, dynamic> json) {
    return AdoptionRequest(
      requestId: json['_id'] ?? '', // Assuming the ID is stored in the '_id' field
      adopterName: json['adopterId'] != null
          ? '${json['adopterId']['firstName'] ?? ''} ${json['adopterId']['lastName'] ?? ''}'.trim() // Combine first and last name, handling nulls
          : 'Unknown Adopter', // Default value if adopterId is null
      petName: json['petId'] != null
          ? json['petId']['name'] ?? 'Unknown Pet' // Default value if name is null
          : 'Unknown Pet', // Default value if petId is null
      requestStatus: json['status'] ?? 'Pending', // Default to 'Pending' if status is null
      requestDate: json['requestDate'] ?? 'Unknown Date', // Default to 'Unknown Date' if requestDate is null
    );
  }
}
