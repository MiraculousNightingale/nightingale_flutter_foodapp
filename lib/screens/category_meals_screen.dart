import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/models/category.dart';
import 'package:nightingale_flutter_foodapp/providers/meal_filters_provider.dart';

import '../models/meal.dart';
import '../widgets/meal_list_item.dart';

class CategoryMealsScreen extends ConsumerWidget {
  final Category category;

  const CategoryMealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String categoryId = category.id;
    final String categoryTitle = category.title;
    final categoryMeals = ref
        .watch(filteredMealsProvider)
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: _buildListOfMealsOrEmpty(context, categoryMeals),
    );
  }

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
}
