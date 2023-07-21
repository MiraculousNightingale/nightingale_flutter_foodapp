import 'package:flutter/material.dart';

class MealFormSwitch extends StatelessWidget {
  const MealFormSwitch(
      {super.key, required this.label, required this.value, this.onChanged});

  final String label;
  final bool value;
  final void Function(bool value)? onChanged;

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
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
