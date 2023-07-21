import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/dummy_data%20(1).dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_category_expandable.dart';
import 'package:nightingale_flutter_foodapp/screens/meal_form/meal_form_string_expandable_screen.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_item.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/meal_form_dropdown.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/meal_form_switch.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/meal.dart';

class MealFormScreen extends StatefulWidget {
  const MealFormScreen({super.key, required this.initialMeal});

  final Meal initialMeal;

  static const ingredientsHeroTag = 'ingredients-expandable';
  static const stepsHeroTag = 'steps-expandable';
  static const categoryHeroTag = 'category-expandable';

  @override
  State<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  final imageUrlController = TextEditingController();
  final titleController = TextEditingController();
  final durationController = TextEditingController();
  late Meal meal;
  late Affordability affordability;
  late Complexity complexity;
  late bool isGlutenFree;
  late bool isLactoseFree;
  late bool isVegan;
  late bool isVegetarian;

  @override
  void initState() {
    super.initState();
    meal = widget.initialMeal.copyWith();
    titleController.text = meal.title;
    imageUrlController.text = meal.imageUrl;
    durationController.text = meal.duration.toString();
    affordability = meal.affordability;
    complexity = meal.complexity;
    isGlutenFree = meal.isGlutenFree;
    isLactoseFree = meal.isLactoseFree;
    isVegan = meal.isVegan;
    isVegetarian = meal.isVegetarian;
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    titleController.dispose();
    durationController.dispose();
    super.dispose();
  }

  void openStepsExpandable() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealFormStringExpandableScreen(
          heroTag: MealFormScreen.stepsHeroTag,
          appBarTitle: meal.title,
          title: 'Steps',
          initialValues: meal.steps,
          onPop: (currentValues) {
            setState(() {
              meal = meal.copyWith(
                steps: [...currentValues],
              );
            });
          },
        ),
      ),
    );
  }

  void openIndgredientsExpandable() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealFormStringExpandableScreen(
          heroTag: MealFormScreen.ingredientsHeroTag,
          appBarTitle: meal.title,
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
  }

  void openCategoryExpandable() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealFormCategoryExpandable(
          heroTag: MealFormScreen.categoryHeroTag,
          appBarTitle: meal.title,
          title: 'Category',
          initialValues: meal.categories,
          onPop: (currentValues) {
            setState(() {
              meal = meal.copyWith(
                categories: [...currentValues],
              );
            });
          },
        ),
      ),
    );
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: imageUrlController,
                      decoration: const InputDecoration(
                        label: Text('Image URL'),
                      ),
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
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
                      onTap: openIndgredientsExpandable,
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
                      onTap: openStepsExpandable,
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
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: openCategoryExpandable,
                      child: Hero(
                        tag: MealFormScreen.categoryHeroTag,
                        child: ExpandableFormContainer(
                          height: 150,
                          margin: const EdgeInsets.all(0),
                          title: 'Category',
                          children: [
                            for (final category in meal.categories) ...[
                              ExpandableFormItem(
                                initialValue: DUMMY_CATEGORIES
                                    .firstWhere((cat) => cat.id == category)
                                    .title,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Duration'),
                      ),
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MealFormEnumDropdown<Complexity>(
                      label: 'Complexity',
                      selectedValue: complexity,
                      allValues: Complexity.values,
                      onChanged: (selectedValue) => setState(() {
                        complexity = selectedValue ?? Complexity.none;
                      }),
                    ),
                    MealFormEnumDropdown<Affordability>(
                      label: 'Affordability',
                      selectedValue: affordability,
                      allValues: Affordability.values,
                      onChanged: (selectedValue) => setState(() {
                        affordability = selectedValue ?? Affordability.none;
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MealFormSwitch(
                      label: 'Gluten Free',
                      value: isGlutenFree,
                      onChanged: (value) => setState(() {
                        isGlutenFree = value;
                      }),
                    ),
                    MealFormSwitch(
                      label: 'Lactose Free',
                      value: isLactoseFree,
                      onChanged: (value) => setState(() {
                        isLactoseFree = value;
                      }),
                    ),
                    MealFormSwitch(
                      label: 'Vegan',
                      value: isVegan,
                      onChanged: (value) => setState(() {
                        isVegan = value;
                      }),
                    ),
                    MealFormSwitch(
                      label: 'Vegetarian',
                      value: isVegetarian,
                      onChanged: (value) => setState(() {
                        isVegetarian = value;
                      }),
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
