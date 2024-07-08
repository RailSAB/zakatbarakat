import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:flutter_app/providers/organization_search_provider.dart';
import 'package:flutter_app/ui/pages/organizations/json_organization.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_app/ui/widgets/organization_card.dart';
// import 'package:flutter_app/ui/widgets/selectableFields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class Organizations extends ConsumerStatefulWidget {
  const Organizations({super.key});

  @override
  ConsumerState<Organizations> createState() => _OrganizationsState();
}

class _OrganizationsState extends ConsumerState<Organizations> {
  bool _isSearching = true;
  List<String> categories = [];
  List<String> countries = [];
  List<String> selectedCategories = [];
  List<String> selectedCountries = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ref.refresh(orgSearchProvider.notifier).reset());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadCategories());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadCountries());
    setState(() {
      _isSearching = false;
    });
  }

  Future<void> _search(List<String> categories, List<String> countries) async {
    if(categories.isEmpty && countries.isEmpty) {
      ref.refresh(orgSearchProvider.notifier).reset();
      return;
    }

    setState(() {
      _isSearching = true; 
    });

    final url = Uri.parse('http://158.160.153.243:8000/organization/search-organization/');
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
    setState(() {});
  }

  void loadCountries() async {
    countries = await getCountries();
    setState(() {});
  }

@override
Widget build(BuildContext context) {
  try {
    return Consumer(
      builder: (context, ref, _) {
        final filteredResults = ref.watch(orgSearchProvider).searchResults;
        return Scaffold(
          appBar: CustomAppBar(
            pageTitle: 'Organizations',
            appBarHeight: 70,
          ),
          backgroundColor: const Color.fromARGB(104, 200, 215, 231),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8.0, // Spacing between buttons
                  runSpacing: 8.0, // Spacing between rows of buttons
                  children: categories.map((category) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedCategories.contains(category)) {
                            selectedCategories.remove(category);
                          } else {
                            selectedCategories.add(category);
                          }
                        });
                        _search(selectedCategories, selectedCountries);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategories.contains(category)
                            ? const Color.fromARGB(255, 96, 218, 255)
                            : const Color.fromARGB(255, 5, 127, 208),
                        textStyle: const TextStyle(
                          fontSize: 14, // Increased font size
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Increased padding
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selectedCategories.contains(category)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8.0, // Spacing between buttons
                  runSpacing: 8.0, // Spacing between rows of buttons
                  children: countries.map((country) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedCountries.contains(country)) {
                            selectedCountries.remove(country);
                          } else {
                            selectedCountries.add(country);
                          }
                        });
                        _search(selectedCategories, selectedCountries);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCountries.contains(country)
                            ? const Color.fromARGB(255, 96, 218, 255)
                            : const Color.fromARGB(255, 5, 127, 208),
                        textStyle: const TextStyle(
                          fontSize: 14, // Increased font size
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Increased padding
                      ),
                      child: Text(
                        country,
                        style: TextStyle(
                          color: selectedCountries.contains(country)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Organizations',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Increased font size
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: _isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : filteredResults.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    OrganizationCard(
                                      id: filteredResults[index].id,
                                      name: filteredResults[index].name,
                                      link: filteredResults[index].link,
                                      description: filteredResults[index].description,
                                      logo: filteredResults[index].logo,
                                      categories: filteredResults[index].categories,
                                      countries: filteredResults[index].countries,
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                );
                              },
                            )
                          : const Center(child: Text('Results are not found')),
                ),
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
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/organization_model.dart';
// import 'package:flutter_app/providers/organization_search_provider.dart';
// import 'package:flutter_app/ui/pages/organizations/json_organization.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';
// import 'package:flutter_app/ui/widgets/organization_card.dart';
// import 'package:flutter_app/ui/widgets/selectableFields.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;


// class Organizations extends ConsumerStatefulWidget {
//   const Organizations({super.key});

//   @override
//   ConsumerState<Organizations> createState() => _OrganizationsState();
// }

// class _OrganizationsState extends ConsumerState<Organizations> {
//   bool _isSearching = true; 
//   List<String> categories = []; // Initialize with an empty list
//   List<String> countries = []; // Initialize with an empty list
//   List<String> selectedCategories = [];
//   List<String> selectedCountries = [];

//   @override
//   void initState() {
//     super.initState();
//     ref.refresh(orgSearchProvider.notifier).reset();
//     loadCategories();
//     loadCountries();
//     _isSearching = false;
//   }

//   Future<void> _search(String query) async {
//     setState(() {
//     _isSearching = true; 
//   });
//     if (query.isEmpty) {
//     ref.refresh(orgSearchProvider.notifier).reset();
//     return;
//   }

//    final url = Uri.parse('http://158.160.153.243:8000/organization/search-organizations');
//     final headers = {'Content-Type': 'application/json'}; 
//     final body = jsonEncode({"searchString": query}); 
//     final response = await http.post(url, headers: headers, body: body);

//   if (response.statusCode == 200) {
//     List<Organization> items = _decodeOrganization(response);
//     ref.read(orgSearchProvider.notifier).searchResults = items;
//   } else {
//     throw Exception('Failed to load search results');
//   }

//   setState(() {
//     _isSearching = false; 
//   });  
//   }

//   List<Organization> _decodeOrganization(dynamic response) {
//     final List<Organization> data = [];
//     try {
//         var jsonData = jsonDecode(response.body);
//         // print('Total Items: ${jsonData.length}');

//         for (var itemData in jsonData) {
//           String? id = itemData['id'] as String?;
//           // print('Item ID: $id');
        
//         List<String>? countries;
//         if (itemData.containsKey('countries') && itemData['countries']!= null) {
//           var dynamicTags = itemData['countries'];
//           countries = (dynamicTags as List<dynamic>).map((country) => country.toString()).toList();
//         } else {
//           countries = [];
//         } 

//         List<String>? categories;
//         if (itemData.containsKey('categories') && itemData['categories']!= null) {
//           var dynamicTags = itemData['categories'];
//           categories = (dynamicTags as List<dynamic>).map((category) => category.toString()).toList();
//         } else {
//           categories = [];
//         } 

//           String? name = itemData['name'] as String?;
//           Uri link = itemData['link'] as Uri;
//           String? description = itemData['description'] as String?;
//           NetworkImage? logo = itemData['logo'] != null ? NetworkImage(itemData['logo']) : null;

//           data.add(Organization(
//             id: id,
//             name: name,
//             link: link,
//             description: description,
//             logo: logo,
//             countries: countries,
//             categories: categories,
//           ));
//         }
//         return data.toList();
//       } catch (e) {
//       throw Exception('Null data');
//     }
//   }

//   void loadCategories() async {
//     categories = await getCategories();
//   }

//   void loadCountries() async { 
//     countries = await getCountries();
//   }

// @override
// Widget build(BuildContext context) {
//     try {
//       return Consumer(
//         builder: (context, watch, _) { 
//           final res = ref.watch(orgSearchProvider).searchResults;
//           return Scaffold(
//             appBar: CustomAppBar(pageTitle: 'Organizations', appBarHeight: 70,),
//             backgroundColor: const Color.fromARGB(104, 200, 215, 231),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const SizedBox(height: 20),
//                   TextField(
//                     onSubmitted: (value) => _search(value),
//                     decoration: const InputDecoration(
//                       labelText: 'Search',
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SelectableFields(
//                       items: categories.isNotEmpty ? categories : [], // Use conditional access
//                       onSelectionChanged: (updatedSelectedCategories) {
//                         setState(() {
//                           selectedCategories = updatedSelectedCategories;
//                         });
//                       }, selectedItems: selectedCategories,
//                     ),
//                   const SizedBox(height: 20),
//                   SelectableFields(
//                       items: countries.isNotEmpty ? countries : [], // Use conditional access
//                       onSelectionChanged: (updatedSelectedCountries) {
//                         setState(() {
//                           selectedCountries = updatedSelectedCountries;
//                         });
//                       }, selectedItems: selectedCountries,
//                     ),
//                   Expanded(
//                     child: 
//                         _isSearching ? const Center(child: CircularProgressIndicator()) : 
//                         ListView.builder(
//                             itemCount: res.length,
//                             itemBuilder: (BuildContext context, int index) {
//                                 return Column(
//                                 children: [
//                                   const SizedBox(height: 5,),
//                                   OrganizationCard(
//                                     id: res[index].id,
//                                     name: res[index].name,
//                                     link: res[index].link,
//                                     description: res[index].description,
//                                     logo: res[index].logo,
//                                     categories: res[index].categories,
//                                     countries: res[index].countries,
//                                   ),
//                                   const SizedBox(height: 5,),
//                                 ],
//                               );
//                               }
//                           )
//                   ),
//                 ],
//               ),
//             ),
//             bottomNavigationBar: const CustomBottomNavBar(index: 2),
//           );
//         },
//       );} catch (e) {
//         throw Exception('Null data');
//       }
//   }
// }