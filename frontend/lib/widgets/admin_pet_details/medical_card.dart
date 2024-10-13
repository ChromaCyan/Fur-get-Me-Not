import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final MedicalHistory medicalHistory;

  const MedicalHistoryWidget({Key? key, required this.medicalHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildInfoContainer('Condition', medicalHistory.condition),
            _buildInfoContainer(
              'Diagnosis Date',
              medicalHistory.diagnosisDate.toLocal().toString().split(' ')[0],
            ),
            _buildInfoContainer('Treatment', medicalHistory.treatment),
            if (medicalHistory.veterinarianName != null)
              _buildInfoContainer(
                  'Veterinarian', medicalHistory.veterinarianName!),
            if (medicalHistory.clinicName != null)
              _buildInfoContainer('Clinic', medicalHistory.clinicName!),
            if (medicalHistory.treatmentDate != null)
              _buildInfoContainer(
                'Treatment Date',
                medicalHistory.treatmentDate!
                    .toLocal()
                    .toString()
                    .split(' ')[0],
              ),
            _buildInfoContainer(
                'Recovery Status', medicalHistory.recoveryStatus),
            if (medicalHistory.notes != null)
              _buildInfoContainer('Notes', medicalHistory.notes!),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Reusable method to create containers for label-value pairs
  Widget _buildInfoContainer(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background for separation
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFE9879),
            ),
          ),
        ],
      ),
    );
  }
}
