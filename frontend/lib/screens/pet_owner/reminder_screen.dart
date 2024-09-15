// import 'package:flutter/material.dart';
// import 'package:fur_get_me_not/screens/pet_owner/menu.dart';
// import 'package:fur_get_me_not/screens/pet_owner/home_screen.dart';
// import 'package:fur_get_me_not/screens/pet_owner/adoption_list.dart';
// import 'package:fur_get_me_not/screens/shared/chat_screen.dart';
// import 'package:fur_get_me_not/screens/pet_owner/reminder_form_screen.dart'; // Import the add reminder form screen
//
// class ReminderScreen extends StatefulWidget {
//   @override
//   _ReminderScreenState createState() => _ReminderScreenState();
// }
//
// class _ReminderScreenState extends State<ReminderScreen> {
//   int selectedIndex = 2;
//
//   final List<Widget> _pages = [
//     HomePage(),
//     AdoptionScreen(),
//     ReminderScreen(),
//     ChatScreen(),
//   ];
//
//   void _onNavBarItemSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => _pages[index],
//         ),
//       );
//     });
//   }
//
//   void _navigateToAddReminderForm() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddReminderForm()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reminders'),
//       ),
//       body: ListView(
//         children: [
//           // Vaccination Schedule Section
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Vaccination Schedule',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ReminderCard(
//                   title: 'Rabies Vaccination',
//                   date: '2024-10-01',
//                   time: '10:00 AM',
//                   description: 'Reminder for the annual rabies vaccination.',
//                 ),
//                 ReminderCard(
//                   title: 'Feline Leukemia',
//                   date: '2024-12-15',
//                   time: '02:00 PM',
//                   description: 'Reminder for the Feline Leukemia booster shot.',
//                 ),
//               ],
//             ),
//           ),
//           // Care Routine Section
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Care Routine',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ReminderCard(
//                   title: 'Daily Feeding',
//                   date: 'Every day',
//                   time: '08:00 AM',
//                   description: 'Reminder to feed your pet in the morning.',
//                 ),
//                 ReminderCard(
//                   title: 'Evening Walk',
//                   date: 'Every day',
//                   time: '06:00 PM',
//                   description: 'Reminder to take your pet for a walk in the evening.',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: selectedIndex,
//         onItemSelected: _onNavBarItemSelected,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToAddReminderForm,
//         child: Icon(Icons.add),
//         tooltip: 'Add Reminder',
//       ),
//     );
//   }
// }
//
// class ReminderCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String time;
//   final String description;
//
//   ReminderCard({
//     required this.title,
//     required this.date,
//     required this.time,
//     required this.description,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 10),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               'Date: $date',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             Text(
//               'Time: $time',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               description,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
