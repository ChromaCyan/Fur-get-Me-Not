import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final MedicalHistory medicalHistory;

  const MedicalHistoryWidget({Key? key, required this.medicalHistory})
      : super(key: key);

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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Condition:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text('${medicalHistory.condition}'),
            Text(
              'Diagnosis Date:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text(
                '${medicalHistory.diagnosisDate.toLocal().toString().split(' ')[0]}'),
            Text(
              'Treatment:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text('${medicalHistory.treatment}'),
            if (medicalHistory.veterinarianName != null) ...[
              Text(
                'Veterinarian:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text('${medicalHistory.veterinarianName!}'),
            ],
            if (medicalHistory.clinicName != null) ...[
              Text(
                'Clinic:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text('${medicalHistory.clinicName!}'),
            ],
            if (medicalHistory.treatmentDate != null) ...[
              Text(
                'Treatment Date:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text(
                  '${medicalHistory.treatmentDate!.toLocal().toString().split(' ')[0]}'),
            ],
            Text(
              'Recovery Status:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text('${medicalHistory.recoveryStatus}'),
            if (medicalHistory.notes != null) ...[
              Text(
                'Notes:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text('${medicalHistory.notes!}'),
            ],
          ],
        ),
      ),
    );
  }
}
