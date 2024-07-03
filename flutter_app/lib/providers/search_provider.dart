import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchResultProvider = ChangeNotifierProvider.autoDispose((ref) => SearchResults());

class SearchResults extends ChangeNotifier {
  List<Article> _searchResultsA = [];
  List<QA> _searchResultsQ = [];

  List<Article> get searchResultsA => _searchResultsA;
  List<QA> get searchResultsQ => _searchResultsQ;

  set searchResultsA(List<Article> newResultsA) {
    _searchResultsA = newResultsA;
    notifyListeners();
  }

  set searchResultsQ(List<QA> newResultsQ) {
    _searchResultsQ = newResultsQ;
    notifyListeners();
  }

  Future<void> resetSearchResults() async {
    final newResultsA = await getArticles();
    _searchResultsA = newResultsA;
    final newResultsQ = await getQuestions();
    _searchResultsQ = newResultsQ;
    notifyListeners();
  }
}
