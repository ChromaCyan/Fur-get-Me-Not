import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_status/adoption_status.dart';

class AdoptionStatusCard extends StatelessWidget {
  final AdoptionStatus adoption;

  const AdoptionStatusCard({Key? key, required this.adoption}) : super(key: key);

  Color _getStatusColor() {
    switch (adoption.status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.blue;
      case 'Adoption Successful':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adoption.petName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Request Date: ${adoption.requestDate}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ${adoption.status}',
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
