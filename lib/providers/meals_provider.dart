import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../dummy_data.dart';

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([]);

  void fetchMeals() {
    state = [...DUMMY_MEALS];
  }

  void addMeal(Meal meal) {
    state = [...state, meal];
  }

  void removeMeal(String mealId) {
    state = state.where((element) => element.id != mealId).toList();
  }
}

final mealsProvider =
    StateNotifierProvider<MealsNotifier, List<Meal>>((ref) => MealsNotifier());
