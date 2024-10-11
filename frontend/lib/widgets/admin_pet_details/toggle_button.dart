import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const ToggleButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100, // Set a fixed width for the button
        height: 50, // Set a fixed height for the button
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white, // Background color based on selection
          borderRadius: BorderRadius.circular(8), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              blurRadius: 4, // Soft shadow
              offset: const Offset(0, 2), // Offset shadow for depth
            ),
          ],
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey, // Border color based on selection
            width: 2, // Border width
          ),
        ),
        alignment: Alignment.center, // Center the text
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // Text color based on selection
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
      ),
    );
  }
}
