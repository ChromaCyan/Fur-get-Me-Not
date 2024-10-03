import 'package:fur_get_me_not/adopter/models/adoption_list/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fur_get_me_not/config/colors.dart';

class CategoryChip extends StatefulWidget {
  final List<Category> categories;
  final void Function(Category) onSelected;

  const CategoryChip({
    Key? key,
    required this.categories,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CategoryChip> createState() => CategoryChipState();
}

class CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        children: widget.categories.map((category) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ChoiceChip(
              avatar: null,
              label: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(category.categoryName),
              ),
              selected: category.isSelected,
              onSelected: (isSelected) {
                widget.onSelected(category);
              },
              selectedColor: Color(0xFFFE9879),
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: category.isSelected ? Colors.white : kBlackColor,
                  ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: category.isSelected ? Color(0xFFFE9879) : kBlackColor,
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}