import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class VaccineHistoryWidget extends StatelessWidget {
  final VaccineHistory vaccineHistory;

  const VaccineHistoryWidget({Key? key, required this.vaccineHistory}) : super(key: key);

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
              'Vaccine History',
            ),
            const SizedBox(height: 8),
            Text('Vaccine Name: ${vaccineHistory.vaccineName}'),
            Text('Vaccination Date: ${vaccineHistory.vaccinationDate.toLocal().toString().split(' ')[0]}'),
            if (vaccineHistory.nextDueDate != null)
              Text('Next Due Date: ${vaccineHistory.nextDueDate!.toLocal().toString().split(' ')[0]}'),
            if (vaccineHistory.veterinarianName != null)
              Text('Veterinarian: ${vaccineHistory.veterinarianName}'),
            if (vaccineHistory.clinicName != null)
              Text('Clinic: ${vaccineHistory.clinicName}'),
            if (vaccineHistory.notes != null)
              Text('Notes: ${vaccineHistory.notes}'),
          ],
        ),
      ),
    );
  }
}
