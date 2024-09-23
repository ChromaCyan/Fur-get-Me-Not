import 'package:fur_get_me_not/models/adoption_form.dart';

class AdoptionRepository {
  // Simulate a network request with a delay
  Future<void> submitAdoptionForm(AdoptionForm model) async {
    await Future.delayed(Duration(seconds: 1));
    // Here you would typically handle the API call
    // For now, just print the model to console
    print('Form submitted: ${model.fullName}, ${model.email}');
  }
}
