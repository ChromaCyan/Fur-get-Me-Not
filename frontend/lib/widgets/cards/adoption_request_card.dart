import 'package:flutter/material.dart';
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
    // Ensure the status matches one of the dropdown options
    _selectedStatus = widget.adoptionRequest.requestStatus;

    // Ensure default status values are consistent
    if (!['Pending', 'Accepted', 'Rejected', 'Adoption Completed'].contains(_selectedStatus)) {
      _selectedStatus = 'Pending'; // Fallback to a default value if needed
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
                  backgroundColor: _getStatusColor(_selectedStatus),
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
                      widget.adoptionRequest.petName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Adopter: ${widget.adoptionRequest.adopterName}'),
                    // Display the requestId
                    Text('Request ID: ${widget.adoptionRequest.requestId}', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Request Date: ${widget.adoptionRequest.requestDate}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
                DropdownButton<String>(
                  value: _selectedStatus,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: _getStatusColor(_selectedStatus)),
                  underline: Container(
                    height: 2,
                    color: _getStatusColor(_selectedStatus),
                  ),
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
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdoptionForm(requestId: widget.adoptionRequest.requestId),
                  ),
                );
              },
              child: Text(
                'View the Adoption Form they filled up:',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
