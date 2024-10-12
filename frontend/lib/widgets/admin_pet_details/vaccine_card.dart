import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class VaccineHistoryWidget extends StatelessWidget {
  final VaccineHistory vaccineHistory;

  const VaccineHistoryWidget({Key? key, required this.vaccineHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set specific width and height for the Card
      width: 380, // Change to your desired width
      // height: 250, // Change to your desired height
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
            Text('Vaccine Name: ${vaccineHistory.vaccineName}'),
            Text(
                'Vaccination Date: ${vaccineHistory.vaccinationDate.toLocal().toString().split(' ')[0]}'),
            if (vaccineHistory.nextDueDate != null)
              Text(
                  'Next Due Date: ${vaccineHistory.nextDueDate!.toLocal().toString().split(' ')[0]}'),
            if (vaccineHistory.veterinarianName != null)
              Text('Veterinarian: ${vaccineHistory.veterinarianName}'),
            if (vaccineHistory.clinicName != null)
              Text('Clinic: ${vaccineHistory.clinicName}'),
            if (vaccineHistory.notes != null)
              Text('Notes: ${vaccineHistory.notes}'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
