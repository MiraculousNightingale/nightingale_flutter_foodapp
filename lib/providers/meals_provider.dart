import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../dummy_data.dart';

// state should be wrapped in AsyncValue to handle async read/write
class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([]) {
    fetchMeals();
  }

  void fetchMeals() {
    print('fetched some meals');
    state = [...DUMMY_MEALS];
  }

  void addMeal(Meal meal) {
    state = [...state, meal];
  }

  // Seems unusual when you don't provide an id as first param
  // but the id shouldn't change if you update anyway.
  void updateMeal(Meal newMeal) {
    final index = state.indexWhere((element) => element.id == newMeal.id);
    state = [...state..[index] = newMeal];
  }

  void removeMeal(String mealId) {
    // state = state.where((element) => element.id != mealId).toList();
    state = [...state.where((element) => element.id != mealId)];
  }
}

final mealsProvider =
    StateNotifierProvider<MealsNotifier, List<Meal>>((ref) => MealsNotifier());
