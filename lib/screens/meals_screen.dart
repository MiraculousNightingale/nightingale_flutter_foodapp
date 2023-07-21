import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/providers/meals_provider.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_screen.dart';

import '../models/meal.dart';
import '../widgets/meal_management_list_item.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Meals'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MealFormScreen(
                    initialMeal: Meal.empty(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) =>
            MealManagementListItem(meal: meals[index]),
      ),
    );
  }
}
