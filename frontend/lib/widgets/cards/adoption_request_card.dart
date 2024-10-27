import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_form.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';
import 'package:fur_get_me_not/adoptee/screens/adoption_request/adoption_form_details.dart';

class AdoptionRequestCard extends StatefulWidget {
  final AdoptionRequest adoptionRequest;
  final Function(String) onStatusChanged;

  const AdoptionRequestCard({
    Key? key,
    required this.adoptionRequest,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  _AdoptionRequestCardState createState() => _AdoptionRequestCardState();
}

class _AdoptionRequestCardState extends State<AdoptionRequestCard> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.adoptionRequest.requestStatus;

    if (!['Pending', 'Accepted', 'Rejected', 'Adoption Completed'].contains(_selectedStatus)) {
      _selectedStatus = 'Pending';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
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

  String _formatRequestDate(String dateString) {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(dateString); // Assuming the date string is in "yyyy-MM-dd" format
    return DateFormat('MMMM dd, yyyy').format(date); // Format date as "October 27, 2024"
  }

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor: _getStatusColor(_selectedStatus),
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
                        widget.adoptionRequest.petName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF21899C),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Adopter: ${widget.adoptionRequest.adopterName}',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Use the formatted date string
            Text(
              'Request Date: ${_formatRequestDate(widget.adoptionRequest.requestDate)}',
              style: TextStyle(fontSize: 14, color: Colors.black87),
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          _selectedStatus = newValue;
                          widget.onStatusChanged(_selectedStatus);
                        }
                      });
                    },
                    items: ['Pending', 'Accepted', 'Rejected', 'Adoption Completed']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdoptionForm(requestId: widget.adoptionRequest.requestId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color(0xFFFE9879),
                ),
                child: Text(
                  'View the Adoption Form',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
