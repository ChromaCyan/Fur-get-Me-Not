import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // Format date function to handle a String date
  String _formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    } catch (e) {
      print("Error parsing date: $e");
      return dateString; // Return the original string if parsing fails
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
      color: const Color(0xFFE1F5FE),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adoption.petName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF21899C),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Request Date: ${_formatDate(adoption.requestDate)}',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
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
