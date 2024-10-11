import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  CategoryBtn({required this.label, required this.onPressed, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF21899C) : Color(0xFFFE9879),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        elevation: 3,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
