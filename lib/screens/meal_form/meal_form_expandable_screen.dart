import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_container.dart';
import 'package:nightingale_flutter_foodapp/widgets/meal_form/expandable_form_item.dart';

/// Designed for String arrays(ingredients, steps) in Meal class.
class MealFormExpandableScreen extends StatefulWidget {
  MealFormExpandableScreen(
      {super.key,
      required this.heroTag,
      required this.title,
      required List<String> initialValues,
      required this.onPop})
      : initialValues = [...initialValues];

  final Object heroTag;
  final String title;
  final List<String> initialValues;
  final void Function(List<String> currentValues) onPop;

  @override
  State<MealFormExpandableScreen> createState() =>
      _MealFormExpandableScreenState();
}

class _MealFormExpandableScreenState extends State<MealFormExpandableScreen> {
  late final List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = [
      for (final value in widget.initialValues) TextEditingController(),
    ];
  }

  @override
  void dispose() {
    // widget.onPop(currentValues);
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> get currentValues => [...controllers.map((e) => e.text)];

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
          title: const Text('Meal Form'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Hero(
          tag: widget.heroTag,
          child: ExpandableFormContainer(
            title: widget.title,
            children: [
              for (var i = 0; i < controllers.length; i++)
                ExpandableFormItem(
                  dismissibleKey: ValueKey(i),
                  initialValue: widget.initialValues[i],
                  controller: controllers[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
