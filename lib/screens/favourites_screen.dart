import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_list_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key, required this.favouriteMeals})
      : super(key: key);

  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text(
          'Nothing here, yet...',
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealListItem(
            meal: favouriteMeals[index],
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
