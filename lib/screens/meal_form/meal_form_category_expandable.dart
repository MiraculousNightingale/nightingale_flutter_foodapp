import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/dummy_data%20(1).dart';
import 'package:nightingale_flutter_foodapp/models/category.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';

import '../../widgets/meal_form/expandable_form_item.dart';

class MealFormCategoryExpandable extends StatefulWidget {
  MealFormCategoryExpandable({
    super.key,
    required this.heroTag,
    required this.appBarTitle,
    required this.title,
    required List<String> initialValues,
    required this.onPop,
  }) : initialValues = [...initialValues];

  final Object heroTag;
  final String appBarTitle;
  final String title;
  final List<String> initialValues;
  final void Function(List<String> currentValues) onPop;

  @override
  State<MealFormCategoryExpandable> createState() =>
      _MealFormCategoryExpandableState();
}

class _MealFormCategoryExpandableState
    extends State<MealFormCategoryExpandable> {
  late final List<String> currentValues;

  var isAdding = false;

  @override
  void initState() {
    super.initState();
    currentValues = [...widget.initialValues];
  }

  List<Category> get unusedCategories => [
        ...DUMMY_CATEGORIES
            .where((element) => !currentValues.contains(element.id))
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        // It's expected that editableItems will be passed into a Meal
        // and then saved with the use of notifier in outside widget.
        widget.onPop(currentValues);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.appBarTitle,
            style: const TextStyle(
              fontSize: 21,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (unusedCategories.isNotEmpty) {
                  setState(() {
                    isAdding = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('All possible categories already selected!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Hero(
          tag: widget.heroTag,
          child: ExpandableFormContainer(
            title: widget.title,
            children: [
              if (isAdding)
                DropdownButton<String>(
                  isExpanded: true,
                  items: [
                    for (final category in unusedCategories)
                      DropdownMenuItem(
                        value: category.id,
                        child: Text(
                          category.title,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        currentValues.insert(0, value);
                        isAdding = false;
                      });
                    }
                  },
                ),
              for (final category in currentValues) ...[
                ExpandableFormItem(
                  initialValue: DUMMY_CATEGORIES
                      .firstWhere((cat) => cat.id == category)
                      .title,
                  dismissibleKey: ValueKey(category),
                  onDismissed: (direction) {
                    currentValues.remove(category);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
