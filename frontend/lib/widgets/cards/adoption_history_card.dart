import 'package:flutter/material.dart';
import 'package:fur_get_me_not/shared/models/adoption_history.dart';
import 'package:intl/intl.dart';

class AdoptionHistoryCard extends StatelessWidget {
  final AdoptionHistory adoptionHistory;

  const AdoptionHistoryCard({Key? key, required this.adoptionHistory}) : super(key: key);

  Color _getStatusColor() {
    if (adoptionHistory.status == 'Completed') {
      return Colors.green;
    } else if (adoptionHistory.status == 'The adoptee has rejected your request') {
      return Colors.red;
    } else if (adoptionHistory.status == 'Adopted by another user') {
      return Colors.yellow;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(adoptionHistory.adoptionDate);

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
                        'Pet: ${adoptionHistory.petName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF21899C),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Display the adopter and adoptee details conditionally
                      if (adoptionHistory.status != 'The adoptee has rejected your request') ...[
                        Text(
                          'Adopter: ${adoptionHistory.adopterName}',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Adoption Date: $formattedDate',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                      // Always show the adoptee name
                      Text(
                        'Adoptee: ${adoptionHistory.adopteeName}',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
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
                  adoptionHistory.status,
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
