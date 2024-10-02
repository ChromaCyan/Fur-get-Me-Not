class AdoptionStatus {
  final String petName;
  final String ownerName;
  final String status; // 'Pending', 'Accepted', 'Rejected'
  final String requestDate;

  AdoptionStatus({
    required this.petName,
    required this.ownerName,
    required this.status,
    required this.requestDate,
  });
}
