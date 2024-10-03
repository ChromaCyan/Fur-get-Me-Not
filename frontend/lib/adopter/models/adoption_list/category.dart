class Category {
  int categoryId;
  String categoryName;
  bool isSelected;

  Category({
    required this.categoryId,
    required this.categoryName,
    bool? isSelected,
  }) : isSelected = isSelected ?? false;
}