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
      backgroundColor: Color(0xFF21899C),
      title: Text(title),
      centerTitle: true,
      leading: hasBackButton
          ? BackButtonWidget(
              onPressed: onBackButtonPressed ?? () => Navigator.of(context).pop(),
              color: Color(0xFFFE9879),
              iconSize: 28.0,
            )
          : null, 
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
