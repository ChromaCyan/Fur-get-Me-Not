import 'package:flutter/material.dart';

// Model area
class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? iconSize;

  BackButtonWidget({
    this.onPressed,
    this.color,
    this.iconSize,
  });

// UI area
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: color ?? Color(0xFFFE9879),
        size: iconSize ?? 24.0,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}
