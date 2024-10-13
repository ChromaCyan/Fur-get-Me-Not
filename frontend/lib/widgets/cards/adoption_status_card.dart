import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_status/adoption_status.dart';

class AdoptionStatusCard extends StatelessWidget {
  final AdoptionStatus adoption;

  const AdoptionStatusCard({Key? key, required this.adoption}) : super(key: key);

  Color _getStatusColor() {
    switch (adoption.status) {
      case 'Pending':
        return Colors.orange;
      case 'Accepted':
        return Colors.blue;
      case 'Adoption Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Current status: ${adoption.status}');
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: const Color(0xFFE1F5FE), // Background color similar to AdoptionRequestCard
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getStatusColor(),
                  child: Icon(
                    Icons.pets,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 15),
                Expanded( // Use Expanded for better layout
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adoption.petName,
                        style: TextStyle(
                          fontSize: 20, // Increased font size for pet name
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF21899C), // Primary color for pet name
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Request Date: ${adoption.requestDate}',
                        style: TextStyle(fontSize: 14, color: Colors.black87), // Updated style
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  adoption.status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
