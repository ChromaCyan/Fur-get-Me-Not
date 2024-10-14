import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onClicked;

  const EditButton({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade400, // Button color
        borderRadius: BorderRadius.circular(25), // Border radius
      ),
      child: Material(
        color: Colors.transparent, // Make Material transparent to see the background color
        child: InkWell(
          splashColor: const Color.fromARGB(65, 255, 255, 255),
          onTap: onClicked,
          child: Container(
            width: 190, // Increased width
            height: 40,
            alignment: Alignment.center, // Center the text
            child: const Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
