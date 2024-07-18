import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:flutter_app/providers/organization_search_provider.dart';
import 'package:flutter_app/providers/selected_categories_provider.dart';
import 'package:flutter_app/providers/selected_countries_provider.dart';
import 'package:flutter_app/ui/pages/organizations/json_organization.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_app/ui/widgets/organization_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class Organizations extends ConsumerStatefulWidget {
  final bool isCharity;
  Organizations({super.key, required this.isCharity});

  @override
  ConsumerState<Organizations> createState() => _OrganizationsState(isCharity: isCharity);
}


  
class _OrganizationsState extends ConsumerState<Organizations> {
  bool isCharity;
  _OrganizationsState({required this.isCharity});
  bool _isSearching = true;
  List<String> categories = [];
  List<String> countries = [];
  late List<String> selectedCategories;
  late List<String> selectedCountries;

@override
void initState() {
  super.initState();
  loadInitialData();
}

  void loadInitialData(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    await ref.read(orgSearchProvider.notifier).reset().then((_) {
      loadCategories();
      loadCountries();
      ref.read(selectedCategoriesProvider.notifier).initializeWithFundsCategory(isCharity);
      ref.read(selectedCountriesProvider.notifier).reset();
    }).then((_) async {
      await _search(ref.read(selectedCategoriesProvider.notifier).selectedCategories, 
              ref.read(selectedCountriesProvider.notifier).selectedCountries);
    });
  });
  }

  Future<void> _search(List<String> categories, List<String> countries) async {
    setState(() {
      _isSearching = true; 
    });

    if(categories.isEmpty && countries.isEmpty) {
      await ref.refresh(orgSearchProvider.notifier).reset();
      setState(() {
        _isSearching = false;
      });
      return;
    }

    final url = Uri.parse('https://weaviatetest.onrender.com/organization/search-organization/');
    final headers = {'Content-Type': 'application/json'}; 
    final body = jsonEncode({"categories": categories, "countries": countries}); 
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

      for (var itemData in jsonData) {
        String? id = itemData['id'] as String?;

        List<String> countries = [];
        if (itemData.containsKey('countries') && itemData['countries'] != null) {
          var dynamicTags = itemData['countries'];
          countries = (dynamicTags as List<dynamic>).map((country) => country.toString()).toList();
        }

        List<String> categories = [];
        if (itemData.containsKey('categories') && itemData['categories'] != null) {
          var dynamicTags = itemData['categories'];
          categories = (dynamicTags as List<dynamic>).map((category) => category.toString()).toList();
        }

        String? name = itemData['name'] as String?;
        Uri link = Uri.parse(itemData['link'] as String);
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
  

  void loadCategories() async {
    categories = await getCategories();
  }

  void loadCountries() async {
    countries = await getCountries();
  }
  @override
Widget build(BuildContext context) {
  try {
    return Consumer(
      builder: (context, ref, _) {
        final filteredResults = ref.watch(orgSearchProvider).searchResults;
        selectedCategories = ref.watch(selectedCategoriesProvider).selectedCategories;
        selectedCountries = ref.watch(selectedCountriesProvider).selectedCountries;
        return Scaffold(
          appBar: CustomAppBar(
            pageTitle: 'Organizations',
            appBarHeight: 70,
          ),
          backgroundColor: Colors.grey[200],
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Take up only necessary width
                            children: [
                              ...selectedCategories.map((item) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Chip(
                                      label: Text(
                                        item,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: const BorderSide(color: Colors.transparent),
                                      ),
                                      onDeleted: () {
                                        selectedCategories.remove(item);
                                        _search(selectedCategories, selectedCountries);
                                      },
                                      deleteIconColor: Colors.white,
                                    ),
                                  )),
                              ...selectedCountries.map((item) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Chip(
                                      label: Text(
                                        item,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: const BorderSide(color: Colors.transparent),
                                      ),
                                      onDeleted: () {
                                        selectedCountries.remove(item);
                                        _search(selectedCategories, selectedCountries);
                                      },
                                      deleteIconColor: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView( // Make the content scrollable
                                child: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return Column(
                                      children: <Widget>[
                                        const SizedBox(height: 40,),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 25), 
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Categories',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ), 
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 8.0,
                                              children: categories.map((item) {
                                                final isSelected = selectedCategories.contains(item);
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (isSelected) {
                                                        selectedCategories.remove(item);
                                                      } else {
                                                        selectedCategories.add(item);
                                                      }
                                                    });
                                                    _search(selectedCategories, selectedCountries);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isSelected ? Colors.grey[800] : const Color.fromARGB(255, 242, 245, 247),
                                                      borderRadius: BorderRadius.circular(20.0),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 14, // Keep the category item text size as 14
                                                        color: isSelected ? Colors.white : Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20,),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 25), // Adds space to the left of the second title
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Countries',
                                              style: TextStyle(fontSize: 20), // Set the font size to 20
                                            ),
                                          ),
                                        ), 
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Adds space to the left of the second Wrap widget
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 8.0,
                                              children: countries.map((item) {
                                                final isSelected = selectedCountries.contains(item);
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (isSelected) {
                                                        selectedCountries.remove(item);
                                                      } else {
                                                        selectedCountries.add(item);
                                                      }
                                                    });
                                                    _search(selectedCategories, selectedCountries);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isSelected ? Colors.grey[800] : const Color.fromARGB(255, 242, 245, 247),
                                                      borderRadius: BorderRadius.circular(20.0),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 14, // Keep the country item text size as 14
                                                        color: isSelected ? Colors.white : Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20,), // Additional space before the close button
                                        ElevatedButton(
                                          onPressed: () => Navigator.pop(context),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Foreground color of the button (text color)
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // No rounded corners
                                            ),
                                            padding: const EdgeInsets.all(20), // Size of the button
                                            textStyle: const TextStyle(fontSize: 18), // Text size
                                          ),
                                          child: const Text('Apply Filter'),
                                        ),
                                        const SizedBox(height: 40,),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        iconSize: 30,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5), // Adds space to the left of the second title
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Organizations',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ), 
                  const SizedBox(height: 20),
                  _isSearching
                        ? const Center(child: CircularProgressIndicator())
                        : filteredResults.isNotEmpty
                            ? GridView.builder(
                                padding: const EdgeInsets.all(8.0), // Optional: Add some padding around the grid
                                shrinkWrap: true, // Ensures the grid only occupies the space needed
                                physics: const NeverScrollableScrollPhysics(), // Disables scrolling in the grid
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Display 2 items per row
                                  crossAxisSpacing: 8.0, // Space between items horizontally
                                  mainAxisSpacing: 8.0, // Space between items vertically
                                  childAspectRatio: 1, // Makes the grid items square
                                ),
                                itemCount: filteredResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: OrganizationCard(
                                      id: filteredResults[index].id,
                                      name: filteredResults[index].name,
                                      link: filteredResults[index].link,
                                      description: filteredResults[index].description,
                                      logo: filteredResults[index].logo,
                                      categories: filteredResults[index].categories,
                                      countries: filteredResults[index].countries,
                                    ),
                                  );
                                },
                              )
                            : const Center(child: Text('Results are not found')),
                ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNavBar(index: 2),
        );
      },
    );
  } catch (e) {
    throw Exception('Null data');
  }
}
}