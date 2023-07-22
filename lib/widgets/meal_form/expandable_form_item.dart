import 'package:flutter/material.dart';

// TODO: this widget should be separated on two widgets
// One is Editable and other is NonEditable

// TODO: Also passing controller and then assigning it a value is strange
// but this can be solved after this widget is refactored into two separate ones.
class ExpandableFormItem extends StatefulWidget {
  const ExpandableFormItem({
    super.key,
    required this.initialValue,
    this.dismissibleKey,
    this.onDismissed,
    this.controller,
  }) : isEditable = controller != null;

  final void Function(DismissDirection direction)? onDismissed;
  final Key? dismissibleKey;
  final TextEditingController? controller;
  final String initialValue;
  final bool isEditable;

  @override
  State<ExpandableFormItem> createState() => _ExpandableFormItemState();
}

class _ExpandableFormItemState extends State<ExpandableFormItem> {
  bool isEditing = false;

  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isEditable) {
      widget.controller!.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String get currentValue =>
      widget.isEditable ? widget.controller!.text : widget.initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final expandableFormItem = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (!isEditing)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text(
                  currentValue,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          if (isEditing)
            Expanded(
              child: TextField(
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
      ),
    );

    // If dismissible key provided - wrap into Dismissible
    if (widget.dismissibleKey != null) {
      return Dismissible(
        key: widget.dismissibleKey!,
        direction:
            isEditing ? DismissDirection.none : DismissDirection.endToStart,
        background: Container(
          color: theme.colorScheme.error,
        ),
        onDismissed: (direction) {
          print('$currentValue dismissed');
          // TODO: assign onDismissed instead of calling it anonymously
          if (widget.onDismissed != null) widget.onDismissed!(direction);
        },
        child: expandableFormItem,
      );
    }
    return expandableFormItem;
  }
}
