import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_item.dart';

/// Designed for String arrays(ingredients, steps) in Meal class.
class MealFormExpandableScreen extends StatelessWidget {
  MealFormExpandableScreen(
      {super.key,
      required this.heroTag,
      required this.title,
      required List<String> initialValue,
      required this.onPop})
      : editableItems = [...initialValue];

  final Object heroTag;
  final String title;
  final List<String> editableItems;
  final void Function(List<String> currentValues) onPop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        // It's expected that editableItems will be passed into a Meal
        // and then saved with the use of notifier in outside widget.
        onPop(editableItems);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meal Form'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Hero(
          tag: heroTag,
          child: ExpandableFormContainer(
            title: title,
            children: [
              for (var i = 0; i < editableItems.length; i++)
                ExpandableFormItem(
                  dismissibleKey: ValueKey(i),
                  initialValue: editableItems[i],
                  controller: TextEditingController(), // TODO: temporary
                ),
            ],
          ),
        ),
      ),
    );
  }
}
