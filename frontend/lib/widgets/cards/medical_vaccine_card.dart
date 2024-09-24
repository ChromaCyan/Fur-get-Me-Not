import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/adopters/adoption_list/pet.dart';

class MedicalHistorySection extends StatelessWidget {
  final Pet pet;

  const MedicalHistorySection({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Medical History:'),
        Image.network(pet.medicalHistoryImageUrl),
        Text('Vaccine History:'),
        Image.network(pet.vaccineHistoryImageUrl),
      ],
    );
  }
}
