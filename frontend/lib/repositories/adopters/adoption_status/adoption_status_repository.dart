import 'dart:io';
import 'package:fur_get_me_not/models/adopters/adoption_status/adoption_status.dart';

class AdoptionStatusRepository {
  Future<List<AdoptionStatus>> fetchAdoptions() async {
    // Simulate fetching data from a remote source.
    await Future.delayed(Duration(seconds: 2));
    return [
      AdoptionStatus(petName: 'Buddy', ownerName: 'John Doe', status: 'Pending', requestDate: '2024-09-20'),
      AdoptionStatus(petName: 'Bella', ownerName: 'Jane Smith', status: 'Accepted', requestDate: '2024-09-18'),
      AdoptionStatus(petName: 'Luna', ownerName: 'Sam Wilson', status: 'Rejected', requestDate: '2024-09-15'),
    ];
  }
}
