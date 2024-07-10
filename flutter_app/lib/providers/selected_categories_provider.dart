import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoriesProvider = ChangeNotifierProvider.autoDispose((ref) => SelectedCategories());

class SelectedCategories extends ChangeNotifier {
  List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  set selectedCategories(List<String> newResults) {
    _selectedCategories = newResults;
    notifyListeners(); // Notify all listeners about the change
  }

  // Method to toggle an item in the list
  void toggleItem(String item) {
    if (_selectedCategories.contains(item)) {
      _selectedCategories.remove(item);
    } else {
      _selectedCategories.add(item);
    }
    notifyListeners(); // Notify listeners after the change
  }
}

