import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}

// Reusable Dropdown Form Field Widget
class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  CustomDropdownFormField({
    required this.labelText,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

// Reusable Image Picker Button
class CustomImagePickerButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final String? selectedImageText;

  CustomImagePickerButton({
    required this.label,
    required this.onPressed,
    this.selectedImageText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            backgroundColor: Colors.yellowAccent,
          ),
          child: Text(label),
        ),
        Text(selectedImageText ?? 'No image selected'),
      ],
    );
  }
}
