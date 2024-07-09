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
                _buildSectionTitle('Categories', Icons.category_rounded),
                const SizedBox(height: 10),
                _buildWrap(categories, selectedCategories, _search),
                const SizedBox(height: 20),
                _buildSectionTitle('Countries', Icons.public_rounded),
                const SizedBox(height: 10),
                _buildWrap(countries, selectedCountries, _search),
                const SizedBox(height: 20),
                _buildSectionTitle('Organizations', Icons.business_rounded),
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
                                    Container(
                                      width: double.infinity,
                                      height: 150,
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

Widget _buildSectionTitle(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: const Color(0xFF004AAD)),  // Приятный оттенок синего
      const SizedBox(width: 10),
      Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004AAD)),  // Приятный оттенок синего
      ),
    ],
  );
}

Widget _buildWrap(List<String> items, List<String> selectedItems, Function onTap) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: items.map((item) {
      final isSelected = selectedItems.contains(item);
      return GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              selectedItems.remove(item);
            } else {
              selectedItems.add(item);
            }
          });
          _search(selectedCategories, selectedCountries);
          // onTap(selectedItems, selectedCountries);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.grey[800], // Изменено здесь
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.white,
            ),
          ),
        ),
      );
    }).toList(),
  );
}

}