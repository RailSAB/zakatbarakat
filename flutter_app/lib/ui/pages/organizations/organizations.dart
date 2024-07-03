import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:flutter_app/providers/organization_search_provider.dart';
import 'package:flutter_app/providers/search_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_app/ui/widgets/organization_card.dart';
import 'package:flutter_app/ui/widgets/selectableFields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class Organizations extends ConsumerStatefulWidget {
  const Organizations({super.key});

  @override
  ConsumerState<Organizations> createState() => _OrganizationsState();
}

class _OrganizationsState extends ConsumerState<Organizations> {
  bool _isSearching = true; 
  List<String> categories = ['Finance', 'Technology', 'Healthcare'];
  List<String> countries = ['USA', 'UK', 'Canada', 'Australia'];
  List<String> selectedCategories = [];
  List<String> selectedCountries = [];

  @override
  void initState() {
    super.initState();
    ref.refresh(orgSearchProvider.notifier).reset();
    _isSearching = false;
  }

  Future<void> _search(String query) async {
    setState(() {
    _isSearching = true; 
  });
    if (query.isEmpty) {
    ref.refresh(orgSearchProvider.notifier).reset();
    return;
  }

   final url = Uri.parse('http://158.160.153.243:8000/organization/search-organizations');
    final headers = {'Content-Type': 'application/json'}; 
    final body = jsonEncode({"searchString": query}); 
    final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    List<Organization> items = _decodeOrganization(response);
    ref.read(orgSearchProvider.notifier).searchResults = items;
  } else {
    throw Exception('Failed to load search results');
  }

  setState(() {
    _isSearching = false; 
  });  
  }

  List<Organization> _decodeOrganization(dynamic response) {
    final List<Organization> data = [];
    try {
        var jsonData = jsonDecode(response.body);
        // print('Total Items: ${jsonData.length}');

        for (var itemData in jsonData) {
          String? id = itemData['id'] as String?;
          // print('Item ID: $id');
        
        List<String>? countries;
        if (itemData.containsKey('countries') && itemData['countries']!= null) {
          var dynamicTags = itemData['countries'];
          countries = (dynamicTags as List<dynamic>).map((country) => country.toString()).toList();
        } else {
          countries = [];
        } 

        List<String>? categories;
        if (itemData.containsKey('categories') && itemData['categories']!= null) {
          var dynamicTags = itemData['categories'];
          categories = (dynamicTags as List<dynamic>).map((category) => category.toString()).toList();
        } else {
          categories = [];
        } 

          String? name = itemData['name'] as String?;
          Uri link = itemData['link'] as Uri;
          String? description = itemData['description'] as String?;
          NetworkImage? logo = itemData['logo'] != null ? NetworkImage(itemData['logo']) : null;

          data.add(Organization(
            id: id,
            name: name,
            link: link,
            description: description,
            logo: logo,
            countries: countries,
            categories: categories,
          ));
        }
        return data.toList();
      } catch (e) {
      throw Exception('Null data');
    }
  }

@override
Widget build(BuildContext context) {
  try{
  return Consumer(
    builder: (context, watch, _) { 
      final res = ref.watch(orgSearchProvider).searchResults;
      return Scaffold(
        appBar: CustomAppBar(pageTitle: 'Organizations', appBarHeight: 70,),
        backgroundColor: const Color.fromARGB(104, 200, 215, 231),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                onSubmitted: (value) => _search(value),
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              SelectableFields(
                  items: categories,
                  onSelectionChanged: (updatedSelectedCategories) {
                    setState(() {
                      selectedCategories = updatedSelectedCategories;
                    });
                  }, selectedItems: selectedCountries,
                ),
              const SizedBox(height: 20),
              SelectableFields(
                  items: countries,
                  onSelectionChanged: (updatedSelectedCountries) {
                    setState(() {
                      selectedCountries = updatedSelectedCountries;
                    });
                  }, selectedItems: selectedCountries,
                ),
              Expanded(
                child: 
                    _isSearching ? const Center(child: CircularProgressIndicator()) : 
                    ListView.builder(
                        itemCount: res.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Column(
                            children: [
                              const SizedBox(height: 5,),
                              OrganizationCard(
                                id: res[index].id,
                                name: res[index].name,
                                link: res[index].link,
                                description: res[index].description,
                                logo: res[index].logo,
                                categories: res[index].categories,
                                countries: res[index].countries,
                              ),
                              const SizedBox(height: 5,),
                            ],
                          );
                          }
                      )
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(index: 2),
      );
    },
  );} catch (e) {
    throw Exception('Null data');
  }
}
}