import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/providers/meals_provider.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_details_screen.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_screen.dart';

import '../models/meal.dart';

class MealManagementListItem extends ConsumerWidget {
  const MealManagementListItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mealsNotifier = ref.read(mealsProvider.notifier);
    const circularRadius = 15.0;
    const padding = EdgeInsets.symmetric(vertical: 10);
    return Material(
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ValueKey(meal),
        onDismissed: (direction) => mealsNotifier.removeMeal(meal.id),
        background: Padding(
          padding: padding,
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              borderRadius: BorderRadius.circular(circularRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete,
                color: theme.colorScheme.onError,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: padding,
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circularRadius)),
            tileColor: theme.colorScheme.onBackground.withOpacity(0.1),
            title: Text(
              meal.title,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealDetailsScreen(meal: meal),
                  ),
                );
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealFormScreen(meal: meal),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }
}
