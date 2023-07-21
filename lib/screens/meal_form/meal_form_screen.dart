import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_expandable_screen.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_item.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/meal.dart';

class MealFormScreen extends StatefulWidget {
  const MealFormScreen({super.key, required this.initialMeal});

  final Meal initialMeal;

  static const ingredientsHeroTag = 'ingredients-expandable';
  static const stepsHeroTag = 'steps-expandable';

  @override
  State<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  late final titleController = TextEditingController();
  late Meal meal;

  @override
  void initState() {
    super.initState();
    meal = widget.initialMeal.copyWith();
    titleController.text = meal.title;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        print('should save meal');
        return true;
      },
      child: Scaffold(
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
                      controller: titleController,
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
                              heroTag: MealFormScreen.ingredientsHeroTag,
                              title: 'Ingredients',
                              initialValues: meal.ingredients,
                              onPop: (currentValues) {
                                setState(() {
                                  meal = meal.copyWith(
                                    ingredients: [...currentValues],
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: MealFormScreen.ingredientsHeroTag,
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
                              heroTag: MealFormScreen.stepsHeroTag,
                              title: 'Steps',
                              initialValues: meal.steps,
                              onPop: (currentValues) {
                                // TODO: save into Meal
                                setState(() {
                                  meal = meal.copyWith(
                                    steps: [...currentValues],
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: MealFormScreen.stepsHeroTag,
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
      ),
    );
  }
}
