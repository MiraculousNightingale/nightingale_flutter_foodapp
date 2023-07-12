import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/models/meal_filter.dart';
import 'package:nightingale_flutter_foodapp/providers/meals_provider.dart';

class MealFiltersNotifier
    extends StateNotifier<Map<MealFilterType, MealFilter>> {
  MealFiltersNotifier()
      : super(
          {
            MealFilterType.glutenFree: MealFilter(
              (meal) => meal.isGlutenFree,
              false,
            ),
            MealFilterType.lactoseFree: MealFilter(
              (meal) => meal.isLactoseFree,
              false,
            ),
            MealFilterType.vegan: MealFilter(
              (meal) => meal.isVegan,
              false,
            ),
            MealFilterType.vegetarian: MealFilter(
              (meal) => meal.isVegetarian,
              false,
            ),
          },
        );

  void toggleFilter(MealFilterType filterType) {
    final filter = state[filterType]!;
    state = {
      ...state,
      filterType: filter.copyWith(isEnabled: !filter.isEnabled),
    };
  }

  void setFilter(MealFilterType filterType, bool isEnabledValue) {
    final filter = state[filterType]!;
    state = {
      ...state,
      filterType: filter.copyWith(isEnabled: isEnabledValue),
    };
  }
}

final mealFiltersProvider =
    StateNotifierProvider<MealFiltersNotifier, Map<MealFilterType, MealFilter>>(
  (ref) => MealFiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters =
      ref.watch(mealFiltersProvider).values.where((filter) => filter.isEnabled);
  return meals
      .where((meal) => filters.every((filter) => filter.check(meal)))
      .toList();
});
