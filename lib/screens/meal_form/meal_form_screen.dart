import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_expandable_screen.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_item.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/meal.dart';

class MealFormScreen extends StatelessWidget {
  const MealFormScreen({super.key, required this.meal});

  final Meal meal;

  static const ingredientsHeroTag = 'ingredients-expandable';
  static const stepsHeroTag = 'steps-expandable';

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
                child: FadeInImage(
                  height: 300,
                  width: double.infinity,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
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
                  GestureDetector(
                    // borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MealFormExpandableScreen(
                            heroTag: ingredientsHeroTag,
                            title: 'Ingredients',
                            initialValue: meal.ingredients,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: ingredientsHeroTag,
                      child: ExpandableFormContainer(
                        height: 150,
                        margin: const EdgeInsets.all(0),
                        title: 'Ingredients',
                        children: [
                          for (final ingredient in meal.ingredients) ...[
                            ExpandableFormItem(initialValue: ingredient),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MealFormExpandableScreen(
                            heroTag: stepsHeroTag,
                            title: 'Steps',
                            initialValue: meal.steps,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: stepsHeroTag,
                      child: ExpandableFormContainer(
                        height: 150,
                        margin: const EdgeInsets.all(0),
                        title: 'Steps',
                        children: [
                          for (final step in meal.steps) ...[
                            ExpandableFormItem(initialValue: step),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ],
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
