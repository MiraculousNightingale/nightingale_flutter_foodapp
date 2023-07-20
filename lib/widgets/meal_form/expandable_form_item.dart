import 'package:flutter/material.dart';

class ExpandableFormItem extends StatefulWidget {
  ExpandableFormItem({
    super.key,
    required this.initialValue,
    TextEditingController? controller,
  })  : isEditable = controller != null,
        controller = controller ?? TextEditingController();

  final TextEditingController controller;
  final String initialValue;
  final bool isEditable;

  @override
  State<ExpandableFormItem> createState() => _ExpandableFormItemState();
}

class _ExpandableFormItemState extends State<ExpandableFormItem> {
  bool isEditing = false;

  // final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        if (!isEditing)
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.controller.text,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
        if (isEditing)
          TextField(
            controller: widget.controller,
            focusNode: focusNode,
            // Events to unfocus and stop editing the item
            onTapOutside: (event) {
              focusNode.unfocus();
              setState(() {
                isEditing = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                isEditing = false;
              });
            },
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        if (widget.isEditable && !isEditing)
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = true;
              });
              focusNode.requestFocus();
            },
            icon: const Icon(Icons.edit),
          ),
      ],
    );
  }
}
