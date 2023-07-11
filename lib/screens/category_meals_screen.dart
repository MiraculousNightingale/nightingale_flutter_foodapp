import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/models/category.dart';

import '../models/meal.dart';
import '../widgets/meal_list_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  final List<Meal> availableMeals;
  final Category category;

  const CategoryMealsScreen({
    Key? key,
    required this.availableMeals,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;

  Widget _buildListOfMealsOrEmpty(
      BuildContext context, List<Meal> categoryMeals) {
    final theme = Theme.of(context);
    if (categoryMeals.isEmpty) {
      return Center(
        child: Text(
          'Nothing here, try a different category!',
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return MealListItem(
          meal: categoryMeals[index],
        );
      },
      itemCount: categoryMeals.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String categoryId = widget.category.id;
    final String categoryTitle = widget.category.title;
    final List<Meal> categoryMeals = widget.availableMeals
        .where((element) => element.categories.contains(categoryId))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: _buildListOfMealsOrEmpty(context, categoryMeals),
    );
  }
}
