// import 'package:flutter/material.dart';

// import 'package:fur_get_me_not/config/colors.dart';

// class SearchField extends StatelessWidget {
//   const SearchField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Container(
//         decoration: const BoxDecoration(
//             color: kGreyColor,
//             borderRadius: BorderRadius.all(Radius.circular(50.0))),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.search_outlined,
//                 color: kOnGreyColor,
//               ),
//               const SizedBox(width: 8.0),
//               Text(
//                 "Search",
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                       color: kOnGreyColor,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController searchController;
  final Function(String) onChanged;
  final Function() onClear;
  final Function() onSearch;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    required this.searchController,
    required this.onChanged,
    required this.onClear,
    required this.onSearch,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearching = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.searchController,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          prefixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFFE9879),),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                )
              : null,

          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.search, color: Color.fromARGB(255, 171, 171, 171),),
                onPressed: null, // Handle search icon click
              ),
              widget.searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Color(0xFFFE9879),),
                      onPressed: widget.onClear,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
