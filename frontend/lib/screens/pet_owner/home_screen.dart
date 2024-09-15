// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fur_get_me_not/models/const.dart';
// import 'package:fur_get_me_not/models/cats_model.dart';
// import 'package:fur_get_me_not/screens/pet_owner/pet_details_screen.dart';
// import 'package:fur_get_me_not/screens/pet_owner/adoption_list.dart';
// import 'package:fur_get_me_not/screens/pet_owner/pet_form_screen.dart';
// import 'package:fur_get_me_not/screens/pet_owner/reminder_screen.dart';
// import 'package:fur_get_me_not/screens/pet_owner/menu.dart';
// import 'dart:async';
// import 'package:fur_get_me_not/screens/shared/chat_screen.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int selectedIndex = 0;
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
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             joinNow(),
//             const SizedBox(height: 30),
//             const SizedBox(height: 25),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Your Pets",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const SizedBox(height: 10),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(cats.length, (index) {
//                   final cat = cats[index];
//                   return petsItems(size, cat);
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddPetForm(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: buttonColor,
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: selectedIndex,
//         onItemSelected: _onNavBarItemSelected,
//       ),
//     );
//   }
//
//   Padding petsItems(Size size, Cat cat) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => PetsDetailPage(cat: cat),
//             ),
//           );
//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: Container(
//             height: size.height * 0.3,
//             width: size.width * 0.55,
//             color: cat.color.withOpacity(0.5),
//             child: Stack(
//               children: [
//                 Positioned(
//                   bottom: -10,
//                   right: -10,
//                   height: 100,
//                   width: 100,
//                   child: Transform.rotate(
//                     angle: 12,
//                     child: Image.network(
//                       "https://clipart-library.com/images/rTnrpap6c.png",
//                       color: cat.color,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 100,
//                   left: -25,
//                   height: 90,
//                   width: 90,
//                   child: Transform.rotate(
//                     angle: -11.5,
//                     child: Image.network(
//                       "https://clipart-library.com/images/rTnrpap6c.png",
//                       color: cat.color,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -10,
//                   right: 10,
//                   child: Hero(
//                     tag: cat.image,
//                     child: Image.asset(
//                       cat.image,
//                       height: size.height * 0.23,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               cat.name,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 color: black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Padding joinNow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           height: 180,
//           width: double.infinity,
//           color: blueBackground,
//           child: Stack(
//             children: [
//               Positioned(
//                 bottom: -20,
//                 right: -30,
//                 width: 100,
//                 height: 100,
//                 child: Transform.rotate(
//                   angle: 12,
//                   child: Image.network(
//                     "https://clipart-library.com/images/rTnrpap6c.png",
//                     color: pawColor2,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -35,
//                 left: -15,
//                 width: 100,
//                 height: 100,
//                 child: Transform.rotate(
//                   angle: -12,
//                   child: Image.network(
//                     "https://clipart-library.com/images/rTnrpap6c.png",
//                     color: pawColor2,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -40,
//                 left: 120,
//                 width: 110,
//                 height: 110,
//                 child: Transform.rotate(
//                   angle: -16,
//                   child: Image.network(
//                     "https://clipart-library.com/images/rTnrpap6c.png",
//                     color: pawColor2,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Josh Brian Bugarin\nPet Owner",
//                       style: TextStyle(
//                         fontSize: 18,
//                         height: 1.1,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
