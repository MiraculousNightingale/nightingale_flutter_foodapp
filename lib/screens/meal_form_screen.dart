import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealFormScreen extends StatelessWidget {
  const MealFormScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (meal.imageUrl.isNotEmpty)
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Title field
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.4),
                        ),
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Indredients',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.4),
                        ),
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Steps',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
