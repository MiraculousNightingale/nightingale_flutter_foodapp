import 'package:flutter/material.dart';

class ExpandableFormContainer extends StatelessWidget {
  const ExpandableFormContainer({
    super.key,
    double? height,
    double? width,
    EdgeInsets? margin,
    EdgeInsets? padding,
    String? title,
    required this.children,
  })  : height = height ?? double.infinity,
        width = width ?? double.infinity,
        margin = margin ?? const EdgeInsets.all(10),
        padding = padding ?? const EdgeInsets.all(10),
        title = title ?? '';

  final double height;
  final double width;
  final List<Widget> children;
  final String title;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onBackground.withOpacity(0.4),
        ),
      ),
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
