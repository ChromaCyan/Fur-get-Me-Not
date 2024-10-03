import 'package:flutter/material.dart';

import 'package:fur_get_me_not/config/colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: const BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(
                Icons.search_outlined,
                color: kOnGreyColor,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Search",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: kOnGreyColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}