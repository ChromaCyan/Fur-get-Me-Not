import 'package:fur_get_me_not/adopter/models/adoption_list/adoption_form.dart';

class AdoptionFormRepository {
  // Simulate a network request with a delay
  Future<void> submitAdoptionForm(AdoptionForm model) async {
    await Future.delayed(Duration(seconds: 1));
    print('Form submitted: ${model.fullName}, ${model.email}');
  }
}
