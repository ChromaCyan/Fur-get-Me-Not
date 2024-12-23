import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class VaccineHistoryWidget extends StatelessWidget {
  final VaccineHistory vaccineHistory;

  const VaccineHistoryWidget({Key? key, required this.vaccineHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
      height: 350, // Fixed height for the container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
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
            const SizedBox(height: 10),
            const Text(
              'Vaccine History',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView( // Allow scrolling for overflowing content
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoContainer('Vaccine Name', vaccineHistory.vaccineName),
                    _buildInfoContainer(
                      'Vaccination Date',
                      vaccineHistory.vaccinationDate.toLocal().toString().split(' ')[0],
                    ),
                    if (vaccineHistory.nextDueDate != null)
                      _buildInfoContainer(
                        'Next Due Date',
                        vaccineHistory.nextDueDate!.toLocal().toString().split(' ')[0],
                      ),
                    if (vaccineHistory.veterinarianName != null)
                      _buildInfoContainer(
                          'Veterinarian', vaccineHistory.veterinarianName!),
                    if (vaccineHistory.clinicName != null)
                      _buildInfoContainer('Clinic', vaccineHistory.clinicName!),
                    if (vaccineHistory.notes != null)
                      _buildInfoContainer('Notes', vaccineHistory.notes!),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create reusable info containers
  Widget _buildInfoContainer(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background color
        borderRadius: BorderRadius.circular(13), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end, // Align text to the right
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFE9879),
              ),
            ),
          ),
        ],
      ),
    );
  }
}