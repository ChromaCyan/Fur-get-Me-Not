import 'package:fur_get_me_not/adopter/models/adoption_list/category.dart';

class CategoryData {
  static List<Category> categories = [
    Category(categoryId: 0, categoryName: "Cat", isSelected: true),
    Category(categoryId: 1, categoryName: "Dog"),
    Category(categoryId: 2, categoryName: "Parrot"),
    Category(categoryId: 3, categoryName: "Lion"),
  ];

  static Category getSelectedCategory() {
    return categories.firstWhere((element) => element.isSelected);
  }

  static void setIsSelected(int categoryId) {
    for (var category in categories) {
      category.isSelected = category.categoryId == categoryId;
    }
  }
}