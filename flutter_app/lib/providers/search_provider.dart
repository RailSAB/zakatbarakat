import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchResultProvider = ChangeNotifierProvider.autoDispose((ref) => SearchResults());

class SearchResults extends ChangeNotifier {
  List<Item> _searchResults = [];

  List<Item> get searchResults => _searchResults;

  set searchResults(List<Item> newResults) {
    _searchResults = newResults;
    notifyListeners();
  }

  Future<void> resetSearchResults() async {
    final newResults = await getData();
    _searchResults = newResults;
    notifyListeners();
  }
}
