import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchResultProvider = ChangeNotifierProvider.autoDispose((ref) => SearchResults());

class SearchResults extends ChangeNotifier {
  List<Article> _searchResults = [];

  List<Article> get searchResults => _searchResults;

  set searchResults(List<Article> newResults) {
    _searchResults = newResults;
    notifyListeners();
  }

  Future<void> resetSearchResults() async {
    final newResults = await getArticles();
    _searchResults = newResults;
    notifyListeners();
  }
}
