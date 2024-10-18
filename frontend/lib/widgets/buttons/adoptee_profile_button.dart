import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/screens/adoptee_profile/adoptee_profile.dart';

// ProfileIconButton widget
class AdopteeProfileIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? iconSize;
  final EdgeInsets? padding;

  AdopteeProfileIconButton({
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
