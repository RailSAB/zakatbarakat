import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:flutter_app/ui/pages/organizations/json_organization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orgSearchProvider = ChangeNotifierProvider.autoDispose((ref) => OrgSearch());

class OrgSearch extends ChangeNotifier {
  List<Organization> _searchResults = [];
  List<Organization> initialResults = [];

  List<Organization> get searchResults => _searchResults;

  set searchResults(List<Organization> newResults) {
    _searchResults = newResults;
    notifyListeners();
  }

  Future<void> reset() async {
    if(initialResults.isEmpty){
      final newResults = await getOrganizations();
    _searchResults = newResults;
    } else{_searchResults = initialResults;}
    notifyListeners();
  }
}
