import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:flutter_app/providers/organization_search_provider.dart';
import 'package:flutter_app/ui/pages/organizations/json_organization.dart';
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
    _isSearching = false;
  }

    Future<void> _search(String query, {int page = 1}) async {
  setState(() {
    _isSearching = true; 
  });
  if (query.isEmpty) {
    ref.refresh(orgSearchProvider.notifier).reset();
    return;
  }

  final url = Uri.parse('http://158.160.153.243:8000/organization/search-organizations');
  final headers = {'Content-Type': 'application/json'}; 
  final body = jsonEncode({"searchString": query, "page": page}); 
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
@override
  Widget build(BuildContext context) {
    try {
      return Consumer(
        builder: (context, watch, _) {
          final res = []; // Заглушка для примерного списка организаций
          final filteredByCategory = selectedCategories.isNotEmpty
              ? res.where((org) => org.categories != null && org.categories!.any((cat) => selectedCategories.contains(cat))).toList()
              : res;

          final filteredResults = selectedCountries.isNotEmpty
              ? filteredByCategory.where((org) => org.countries != null && org.countries!.any((country) => selectedCountries.contains(country))).toList()
              : filteredByCategory;

          return Scaffold(
            appBar: CustomAppBar(pageTitle: 'Organizations', appBarHeight: 70),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (selectedCategories.contains(category)) {
                                  selectedCategories.remove(category);
                                } else {
                                  selectedCategories.add(category);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedCategories.contains(category) ? Colors.blue : Colors.grey,
                            ),
                            child: Text(category),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: countries.map((country) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (selectedCountries.contains(country)) {
                                  selectedCountries.remove(country);
                                } else {
                                  selectedCountries.add(country);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedCountries.contains(country) ? Colors.blue : Colors.grey,
                            ),
                            child: Text(country),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Organizations',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _isSearching
                        ? const Center(child: CircularProgressIndicator())
                        : filteredResults.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 5),
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
                          : Center(child: Text('Results are not found')),
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