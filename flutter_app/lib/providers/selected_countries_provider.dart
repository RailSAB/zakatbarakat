import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCountriesProvider = ChangeNotifierProvider.autoDispose((ref) => SelectedCountries());

class SelectedCountries extends ChangeNotifier {
  List<String> _selectedCountries = [];

  List<String> get selectedCountries => _selectedCountries;

  set selectedCountries(List<String> newResults) {
    _selectedCountries = newResults;
    notifyListeners();
  }

  void reset() {
    _selectedCountries = [];
    notifyListeners();
  }
}
