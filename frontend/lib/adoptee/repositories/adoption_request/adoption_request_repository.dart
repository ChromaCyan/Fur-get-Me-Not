import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';

class AdoptionRequestRepository {
  List<AdoptionRequest> _adoptionRequests = [
    AdoptionRequest(
      adopterName: 'John Doe',
      petName: 'Buddy',
      requestStatus: 'Pending',
      requestDate: '2024-09-25',
    ),
    AdoptionRequest(
      adopterName: 'Jane Smith',
      petName: 'Luna',
      requestStatus: 'Pending',
      requestDate: '2024-09-23',
    ),
  ];

  Future<List<AdoptionRequest>> getAdoptionRequests() async {
    await Future.delayed(Duration(seconds: 1));
    return _adoptionRequests;
  }

  Future<void> updateAdoptionRequestStatus(int index, String newStatus) async {
    await Future.delayed(Duration(milliseconds: 500));
    _adoptionRequests[index].requestStatus = newStatus;
  }
}
