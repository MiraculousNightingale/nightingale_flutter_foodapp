import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/providers/meals_provider.dart';

import '../models/meal.dart';

class MealManagementListItem extends ConsumerWidget {
  const MealManagementListItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mealsNotifier = ref.read(mealsProvider.notifier);
    return Material(
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => mealsNotifier.removeMeal(meal.id),
        background: Container(
          color: theme.colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            tileColor: theme.colorScheme.onBackground.withOpacity(0.1),
            title: Text(
              meal.title,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }
}
