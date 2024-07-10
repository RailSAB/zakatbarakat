import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/selectable_field.dart';

class SelectableFields extends StatelessWidget {
  final List<String> items;
  List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  SelectableFields({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this list
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedItems.contains(item);
        return SelectableField(
          label: item,
          isSelected: isSelected,
          onSelect: () {
            final updatedItems = List<String>.from(selectedItems);
            if (isSelected) {
              updatedItems.remove(item);
            } else {
              updatedItems.add(item);
            }
            selectedItems = updatedItems;
            onSelectionChanged(updatedItems);
          },
        );
      },
    );
  }
}
