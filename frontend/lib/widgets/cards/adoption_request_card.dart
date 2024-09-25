import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/adoptee/adoption_request/adoption_request.dart';
import 'package:fur_get_me_not/screens/adopter/adoption_list/adoption_form.dart';

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
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Accepted':
        return Colors.green;
      case 'Completed':
        return Colors.yellow;
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
                  items: ['Pending', 'Accepted', 'Rejected', 'Completed']
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
            // Add clickable text here
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdoptionForm()),
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
