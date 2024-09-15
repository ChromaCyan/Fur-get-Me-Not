import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(
    color: Colors.grey[300] ?? Colors.grey,
    blurRadius: 30,
    offset: Offset(0, 10),
  )
];

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'images/dog.png'},
  {'name': 'Bunnies', 'iconPath': 'images/rabbit.png'},
  {'name': 'Parrots', 'iconPath': 'images/parrot.png'},
];

List<Map> drawerItems = [
  {
    'icon': FontAwesomeIcons.paw,
    'title': 'Your Pet List'
  },
  {
    'icon': Icons.notifications,
    'title': 'Pet Reminders'
  },
  {
    'icon': FontAwesomeIcons.plusCircle,
    'title': 'Pet Adoption Listing'
  },
  {
    'icon': Icons.settings,
    'title': 'Profile Settings'
  },
  {
    'icon': Icons.mail,
    'title': 'Messages'
  },
  {
    'icon': FontAwesomeIcons.signOutAlt,
    'title': 'Logout'
  },
];
