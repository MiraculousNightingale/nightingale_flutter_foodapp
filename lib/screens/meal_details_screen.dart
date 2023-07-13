import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/dummy_data%20(1).dart';
import 'package:nightingale_flutter_foodapp/providers/favorite_meals_provider.dart';

import '../models/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  static const String routeName = '/meal-detail';

  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);

  final Meal meal;

  Widget _buildSectionTitle(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final ingredient in meal.ingredients)
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(ingredient),
                      ),
                    ),
                ],
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              child: Column(
                children: [
                  for (var i = 0; i < meal.steps.length; i++)
                    Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${i + 1}'),
                          ),
                          title: Text(meal.steps[i]),
                        ),
                        // don't add divider after last element
                        if (i < meal.steps.length - 1)
                          const Divider(
                            color: Colors.black,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(favoriteMealsProvider.notifier)
            .toggleMealFavoriteStatus(meal),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }
}
