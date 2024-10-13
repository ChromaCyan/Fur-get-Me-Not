import 'package:flutter/material.dart';
import 'package:fur_get_me_not/widgets/buttons/back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.hasBackButton = false,
    this.onBackButtonPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF21899C), // Background color of AppBar
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      // AppBar title
      centerTitle: true, // Center the title
      leading: hasBackButton
          ? BackButtonWidget(
              onPressed:
                  onBackButtonPressed ?? () => Navigator.of(context).pop(),
              color: Color(0xFFFE9879), // Back button color
              iconSize: 28.0, // Size of the back button icon
            )
          : null, // No leading icon if `hasBackButton` is false
      actions: actions, // Optional action buttons
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Default height of the AppBar
}
