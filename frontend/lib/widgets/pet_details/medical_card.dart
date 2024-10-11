import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final MedicalHistory medicalHistory;

  const MedicalHistoryWidget({Key? key, required this.medicalHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical History',
            ),
            const SizedBox(height: 8),
            Text('Condition: ${medicalHistory.condition}'),
            Text('Diagnosis Date: ${medicalHistory.diagnosisDate.toLocal().toString().split(' ')[0]}'),
            Text('Treatment: ${medicalHistory.treatment}'),
            if (medicalHistory.veterinarianName != null)
              Text('Veterinarian: ${medicalHistory.veterinarianName}'),
            if (medicalHistory.clinicName != null)
              Text('Clinic: ${medicalHistory.clinicName}'),
            if (medicalHistory.treatmentDate != null)
              Text('Treatment Date: ${medicalHistory.treatmentDate!.toLocal().toString().split(' ')[0]}'),
            Text('Recovery Status: ${medicalHistory.recoveryStatus}'),
            if (medicalHistory.notes != null)
              Text('Notes: ${medicalHistory.notes}'),
          ],
        ),
      ),
    );
  }
}
