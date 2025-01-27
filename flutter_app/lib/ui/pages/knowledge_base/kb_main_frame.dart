import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/search_provider.dart';
import 'package:flutter_app/ui/pages/knowledge_base/send_request.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/article.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/models/article_m.dart';
import 'package:http/http.dart' as http;

class KBPage extends ConsumerStatefulWidget {
  const KBPage({super.key});

  @override
  ConsumerState<KBPage> createState() => _KBState();
}

class _KBState extends ConsumerState<KBPage> {
  bool _isSearching = true;
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    //this is needed so that it shows curcular bar until the data is loaded
    _refreshCompleter = Completer<void>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.refresh(searchResultProvider.notifier).resetSearchResults();
      _refreshCompleter?.complete();
      _refreshCompleter = null;
    });

    _refreshCompleter?.future.then((_) => setState(() {
          _isSearching = false;
        }));
  }

  Future<void> _search(String query) async {
    setState(() {
      _isSearching = true;
    });

    if (query.isEmpty) {
      await ref.refresh(searchResultProvider.notifier).resetSearchResults();
      setState(() {
        _isSearching = false;
      });
      return;
    }

  
    final url = Uri.parse('https://weaviatetest.onrender.com/knowledge-base/search-article/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"searchString": query});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      List<Article> items = _decodeArticles(response);
      ref.read(searchResultProvider.notifier).searchResults = items;
    } else {
      throw Exception('Failed to load search results');
    }
    setState(() {
      _isSearching = false;
    });
  }

  List<Article> _decodeArticles(http.Response response) {
    final List<Article> data = [];
    try {
      var jsonData = jsonDecode(response.body) as List<dynamic>;
      for (var itemData in jsonData) {
        data.add(Article.fromJson(itemData as Map<String, dynamic>));
      }
      return data;
    } catch (e) {
      throw Exception('Failed to decode articles: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final searchResults = ref.watch(searchResultProvider).searchResults;
        return Scaffold(
          appBar: CustomAppBar(
            pageTitle: 'Knowledge Base',
            appBarHeight: 70,
          ),
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                TextField(
                  onSubmitted: (value) => _search(value),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: searchResults.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < searchResults.length) {
                              return Column(
                                children: [
                                  const SizedBox(height: 5),
                                  ArticleCard(
                                    id: searchResults[index].id,
                                    tags: searchResults[index].tags,
                                    title: searchResults[index].title,
                                    text: searchResults[index].text,
                                    content: searchResults[index].content,
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Didn't find an answer to your question?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigate to the new page for sending requests
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SendRequest()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: const Text("Send Request"),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }
                          },
                        ),
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
