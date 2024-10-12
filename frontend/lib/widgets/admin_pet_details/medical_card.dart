import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final MedicalHistory medicalHistory;

  const MedicalHistoryWidget({Key? key, required this.medicalHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set specific width and height for the Card
      width: 300, // Change to your desired width
      // height: 300, // Change to your desired height if needed
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 10.0, // How blurred the shadow is
            spreadRadius: 0.5, // How much the shadow spreads
            offset: Offset(0, 0), // Direction of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Condition: ${medicalHistory.condition}'),
            Text(
                'Diagnosis Date: ${medicalHistory.diagnosisDate.toLocal().toString().split(' ')[0]}'),
            Text('Treatment: ${medicalHistory.treatment}'),
            if (medicalHistory.veterinarianName != null)
              Text('Veterinarian: ${medicalHistory.veterinarianName}'),
            if (medicalHistory.clinicName != null)
              Text('Clinic: ${medicalHistory.clinicName}'),
            if (medicalHistory.treatmentDate != null)
              Text(
                  'Treatment Date: ${medicalHistory.treatmentDate!.toLocal().toString().split(' ')[0]}'),
            Text('Recovery Status: ${medicalHistory.recoveryStatus}'),
            if (medicalHistory.notes != null)
              Text('Notes: ${medicalHistory.notes}'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
