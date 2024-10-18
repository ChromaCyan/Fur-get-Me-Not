import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/screens/adopter_profile/adopter_profile.dart';

// ProfileIconButton widget
class ProfileIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? iconSize;
  final EdgeInsets? padding;

  ProfileIconButton({
    this.onPressed,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              size: iconSize ?? 30,
            ),
            onPressed: onPressed ??
                () {
                  // Navigate to ProfilePage when the icon is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}
