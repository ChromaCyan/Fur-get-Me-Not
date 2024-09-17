import 'dart:io';
import 'package:fur_get_me_not/models/adoption_status.dart';

class AdoptionStatusRepository {
  Future<List<AdoptionRequest>> getAdoptions() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      AdoptionRequest(
        id: '1',
        petName: 'Max',
        ownerName: 'John Doe',
        adoptionDate: DateTime.now().subtract(Duration(days: 30)),
        status: 'Approved',
      ),
      AdoptionRequest(
        id: '2',
        petName: 'Whiskers',
        ownerName: 'Jane Smith',
        adoptionDate: DateTime.now().subtract(Duration(days: 15)),
        status: 'Pending',
      ),
      AdoptionRequest(
        id: '3',
        petName: 'Fluffy',
        ownerName: 'Bob Johnson',
        adoptionDate: DateTime.now().add(Duration(days: 7)),
        status: 'Rejected',
      ),
    ];
  }
}
