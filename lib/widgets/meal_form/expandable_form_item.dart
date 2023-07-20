import 'package:flutter/material.dart';

class ExpandableFormItem extends StatelessWidget {
  const ExpandableFormItem({
    super.key,
    required this.text,
    this.editable = false,
  });

  final String text;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
        if (editable)
          IconButton(
            onPressed: () {
              print('Pressed $text edit button');
            },
            icon: const Icon(Icons.edit),
          ),
      ],
    );
  }
}
