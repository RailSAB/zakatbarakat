import 'package:flutter/material.dart';
import 'package:flutter_app/models/article_m.dart';
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchResultProvider = ChangeNotifierProvider.autoDispose((ref) => SearchResults());

class SearchResults extends ChangeNotifier {
  List<Article> _searchResults = [];
  List<Article> initialResults = [];

  List<Article> get searchResults => _searchResults;

  set searchResults(List<Article> newResults) {
    _searchResults = newResults;
    notifyListeners();
  }

  Future<void> resetSearchResults() async {
    if(initialResults.isEmpty){
    final newResults = await ArticleAPI.getArticles();
    _searchResults = newResults;
    } else{_searchResults = initialResults;}
    notifyListeners();
  }
}
