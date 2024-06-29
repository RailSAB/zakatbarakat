import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/providers/search_provider.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/article.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;

class KBPage extends ConsumerStatefulWidget {
  const KBPage({super.key});

  @override
  ConsumerState<KBPage> createState() => _KBState();
}

class _KBState extends ConsumerState<KBPage> {
  bool _isSearching = false; 

  @override
  void initState() {
    super.initState();
    ref.refresh(searchResultProvider.notifier).resetSearchResults();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
    ref.refresh(searchResultProvider.notifier).resetSearchResults();
    return;
  }
  setState(() {
    _isSearching = true; // Set to true when starting the search
  });

    final url = Uri.parse('http://158.160.153.243:8000/knowledge-base/search-article/');
    final headers = {'Content-Type': 'application/json'}; 
    final body = jsonEncode({"searchString": query}); 
    final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    List<Item> items = _decodeData(response);
    ref.read(searchResultProvider.notifier).searchResults = items;
    setState(() {
    _isSearching = false; // Set to true when starting the search
  });
  } else {
    throw Exception('Failed to load search results');
  }
  }

  List<Item> _decodeData(dynamic response) {
    final List<Item> _data = [];
    try {
        var jsonData = jsonDecode(response.body);
        //print('Total Items: ${jsonData.length}');
        // var itemData = jsonData;
        for (var itemData in jsonData) {
          String? id = itemData['id'] as String?;
          // print('Item ID: $id');
        
        List<String>? tags;

        if (itemData.containsKey('tags') && itemData['tags']!= null) {
          var dynamicTags = itemData['tags'];
          tags = (dynamicTags as List<dynamic>).map((tag) => tag.toString()).toList();
        } else {
          tags = [];
        } 
        
          // print('Tags: $tags');
          String? title = itemData['title'] as String?;
          // print('Title: $title');
          String? text = itemData['text'] as String?;
          // print('Text: $text');
          List<Operation> ops = (itemData['content']['ops'] as List)
            .map((op) => Operation(insert: op['insert']?? '', attributes: op['attributes']?? {},))
            .toList();
          Content content = Content(ops: ops);
          // print('Content: $content');

          _data.add(Item(
            id: id,
            tags: tags,
            title: title,
            text: text,
            content: content,
          ));
        }
        return _data.toList();
      } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Null data');
    }
  }

@override
Widget build(BuildContext context) {
  return Consumer(
    builder: (context, watch, _) { 
      final searchResults = ref.watch(searchResultProvider).searchResults; 
      return Scaffold(
        appBar: CustomAppBar(pageTitle: 'Knowledge Base', appBarHeight: 70,),
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
              Expanded(
                child: 
                    _isSearching ? const Center(child: CircularProgressIndicator()) 
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              const SizedBox(height: 5,),
                              Article(
                                id: searchResults[index].id,
                                tags: searchResults[index].tags,
                                title: searchResults[index].title,
                                text: searchResults[index].text,
                                content: searchResults[index].content,
                              ),
                              const SizedBox(height: 5,),
                            ],
                          );
                        },
                      )
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(index: 1),
      );
    },
  );
}
}
