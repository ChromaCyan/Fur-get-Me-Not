// import 'package:fur_get_me_not/adopter/models/adoption_list/category.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:fur_get_me_not/config/colors.dart';

// class CategoryChip extends StatefulWidget {
//   final List<Category> categories;
//   final void Function(Category) onSelected;

//   const CategoryChip({
//     Key? key,
//     required this.categories,
//     required this.onSelected,
//   }) : super(key: key);

//   @override
//   State<CategoryChip> createState() => CategoryChipState();
// }

// class CategoryChipState extends State<CategoryChip> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         scrollDirection: Axis.horizontal,
//         children: widget.categories.map((category) {
//           return Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: ChoiceChip(
//               avatar: null,
//               label: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(category.categoryName),
//               ),
//               selected: category.isSelected,
//               onSelected: (isSelected) {
//                 widget.onSelected(category);
//               },
//               selectedColor: Color(0xFFFE9879),
//               labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: category.isSelected ? Colors.white : kBlackColor,
//                   ),
//               backgroundColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                   color: category.isSelected ? Color(0xFFFE9879) : kBlackColor,
//                   width: 1.5,
//                 ),
//                 borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fur_get_me_not/widgets/buttons/category_button.dart';

class CategoryArea extends StatefulWidget {
  @override
  _CategoryAreaState createState() => _CategoryAreaState();
}

class _CategoryAreaState extends State<CategoryArea> {
  int _selectedIndex = 0;

  void _onCategoryButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 75,
          child: Row(
            children: [
              CategoryBtn(
                label: "All",
                onPressed: () {
                  _onCategoryButtonPressed(0);
                },
                isSelected: _selectedIndex == 0,
              ),
              SizedBox(width: 10),
              CategoryBtn(
                label: "Dogs",
                onPressed: () {
                  _onCategoryButtonPressed(1); 
                },
                isSelected: _selectedIndex == 1,
              ),
              SizedBox(width: 10),
              CategoryBtn(
                label: "Cats",
                onPressed: () {
                  _onCategoryButtonPressed(2);
                },
                isSelected: _selectedIndex == 2,
              ),
              SizedBox(width: 10),
              CategoryBtn(
                label: "Birds",
                onPressed: () {
                  _onCategoryButtonPressed(3);
                },
                isSelected: _selectedIndex == 3,
              ),
              SizedBox(width: 10),
              CategoryBtn(
                label: "Rodents",
                onPressed: () {
                  _onCategoryButtonPressed(4);
                },
                isSelected: _selectedIndex == 4,
              ),
              SizedBox(width: 10),
              CategoryBtn(
                label: "Wilds",
                onPressed: () {
                  _onCategoryButtonPressed(5);
                },
                isSelected: _selectedIndex == 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
