import 'package:flutter/material.dart';

class MealFormEnumDropdown<T> extends StatelessWidget {
  const MealFormEnumDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.allValues,
    required this.onChanged,
  });

  final String label;
  final T selectedValue;
  final List<dynamic> allValues;
  final void Function(T? selectedValue)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        //Expanded
        DropdownButton<T>(
          // isExpanded: true,
          value: selectedValue,
          items: [
            for (final value in allValues)
              DropdownMenuItem(
                value: value,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    (value as Enum).name.replaceRange(
                          0,
                          1,
                          value.name[0].toUpperCase(),
                        ),
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
