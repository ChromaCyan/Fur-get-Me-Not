class AdoptionRequest {
  final String adopterName;
  final String petName;
  String requestStatus;
  final String requestDate;

  AdoptionRequest({
    required this.adopterName,
    required this.petName,
    this.requestStatus = 'Pending',
    required this.requestDate,
  });
}
