import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoriesProvider = ChangeNotifierProvider.autoDispose((ref) => SelectedCategories());

class SelectedCategories extends ChangeNotifier {
  List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  set selectedCategories(List<String> newResults) {
    _selectedCategories = newResults;
    notifyListeners(); 
  }

  void initializeWithFundsCategory(bool isCharity) {
    _selectedCategories = [];
    if (isCharity) {
      if(_selectedCategories.isEmpty) {
         _selectedCategories.add('Charity funds');
      }
    } else if(_selectedCategories.contains('Charity funds')){
      _selectedCategories.remove('Charity funds');
    }
    notifyListeners();
  }

  void toggleItem(String item) {
    if (_selectedCategories.contains(item)) {
      _selectedCategories.remove(item);
    } else {
      _selectedCategories.add(item);
    }
    notifyListeners(); 
  }
}

