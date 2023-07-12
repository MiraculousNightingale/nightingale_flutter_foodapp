import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/providers/favorite_meals_provider.dart';
import 'package:nightingale_flutter_foodapp/providers/meals_provider.dart';

import '../models/meal.dart';
import '../widgets/meal_list_item.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favouriteMeals = ref.watch(favoriteMealsProvider);

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
