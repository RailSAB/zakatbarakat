
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/itemkb_model.dart';
// import 'package:flutter_app/providers/search_provider.dart';
// import 'package:flutter_app/ui/pages/knowledge_base/send_request.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_app/ui/widgets/article.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:http/http.dart' as http;

// class KBPage extends ConsumerStatefulWidget {
//   const KBPage({super.key});

//   @override
//   ConsumerState<KBPage> createState() => _KBState();
// }

// class _KBState extends ConsumerState<KBPage> {
//   bool _isSearching = true;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback(
//         (_) => ref.refresh(searchResultProvider.notifier).resetSearchResults());
//     _isSearching = false;
//   }

//   Future<void> _search(String query) async {
//     setState(() {
//       _isSearching = true;
//     });

//     if (query.isEmpty) {
//       ref.refresh(searchResultProvider.notifier).resetSearchResults();
//       return;
//     }

//     // Get articles
//     final url = Uri.parse('http://158.160.153.243:8000/knowledge-base/search-article/');
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({"searchString": query});
//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 200) {
//       List<Article> items = _decodeArticles(response);
//       ref.read(searchResultProvider.notifier).searchResultsA = items;
//     } else {
//       throw Exception('Failed to load search results');
//     }

//     // Get questions
//     final url1 = Uri.parse('http://158.160.153.243:8000/qna/search-question/');
//     final headers1 = {'Content-Type': 'application/json'};
//     final body1 = jsonEncode({"searchString": query});
//     final response1 = await http.post(url1, headers: headers1, body: body1);

//     if (response1.statusCode == 200) {
//       List<QA> items = _decodeQuestions(response1);
//       ref.read(searchResultProvider.notifier).searchResultsQ = items;
//     } else {
//       throw Exception('Failed to load search results');
//     }

//     setState(() {
//       _isSearching = false;
//     });
//   }

//   List<Article> _decodeArticles(dynamic response) {
//     final List<Article> data = [];
//     try {
//       var jsonData = jsonDecode(response.body);
//       for (var itemData in jsonData) {
//         String? id = itemData['id'] as String?;

//         List<String>? tags;

//         if (itemData.containsKey('tags') && itemData['tags'] != null) {
//           var dynamicTags = itemData['tags'];
//           tags = (dynamicTags as List<dynamic>).map((tag) => tag.toString()).toList();
//         } else {
//           tags = [];
//         }

//         String? title = itemData['title'] as String?;
//         String? text = itemData['text'] as String?;
//         List<Operation> ops = (itemData['content']['ops'] as List)
//             .map((op) => Operation(
//                   insert: op['insert'] ?? '',
//                   attributes: op['attributes'] ?? {},
//                 ))
//             .toList();
//         Content content = Content(ops: ops);

//         data.add(Article(
//           id: id,
//           tags: tags,
//           title: title,
//           text: text,
//           content: content,
//         ));
//       }
//       return data.toList();
//     } catch (e) {
//       throw Exception('Null data');
//     }
//   }

//   List<QA> _decodeQuestions(dynamic response) {
//     final List<QA> data = [];
//     try {
//       var jsonData = jsonDecode(response.body);
//       for (var itemData in jsonData) {
//         String? quest = itemData['question'] as String?;
//         String? ans = itemData['answer'] as String?;
//         data.add(QA(
//           headerText: quest,
//           expandedText: ans,
//         ));
//       }
//       return data.toList();
//     } catch (e) {
//       throw Exception('Null data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, watch, _) {
//         final searchResults = ref.watch(searchResultProvider).searchResultsA;
//         final questions = ref.watch(searchResultProvider).searchResultsQ;
//         return Scaffold(
//           appBar: CustomAppBar(
//             pageTitle: 'Knowledge Base',
//             appBarHeight: 70,
//           ),
//           backgroundColor: Colors.grey[200],
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(height: 20),
//                 TextField(
//                   onSubmitted: (value) => _search(value),
//                   decoration: InputDecoration(
//                     labelText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: _isSearching
//                       ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           itemCount: searchResults.length + questions.length + 1,
//                           itemBuilder: (BuildContext context, int index) {
//                             if (index < questions.length) {
//                               return ExpansionTile(
//                                 title: Text(questions[index].headerText ?? ''),
//                                 children: <Widget>[
//                                   ListTile(
//                                     title: Text(questions[index].expandedText ?? ''),
//                                   ),
//                                 ],
//                               );
//                             } else if (index < searchResults.length + questions.length) {
//                               return Column(
//                                 children: [
//                                   const SizedBox(height: 5),
//                                   ArticleCard(
//                                     id: searchResults[index - questions.length].id,
//                                     tags: searchResults[index - questions.length].tags,
//                                     title: searchResults[index - questions.length].title,
//                                     text: searchResults[index - questions.length].text,
//                                     content: searchResults[index - questions.length].content,
                                    
//                                   ),
//                                   const SizedBox(height: 5),
//                                 ],
//                               );
//                             } else {
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const SizedBox(height: 20),
//                                   const Text(
//                                     "Didn't find an answer to your question?",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Navigate to the new page for sending requests
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (context) => const SendRequest()),
//                                       );
//                                     },
//                                     child: const Text("Send Request"),
//                                   ),
//                                   const SizedBox(height: 20),
//                                 ],
//                               );
//                             }
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//           bottomNavigationBar: const CustomBottomNavBar(index: 1),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/providers/search_provider.dart';
import 'package:flutter_app/ui/pages/knowledge_base/send_request.dart';
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
  bool _isSearching = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.refresh(searchResultProvider.notifier).resetSearchResults());
    _isSearching = false;
  }

  Future<void> _search(String query) async {
    setState(() {
      _isSearching = true;
    });

    if (query.isEmpty) {
      ref.refresh(searchResultProvider.notifier).resetSearchResults();
      return;
    }

    // Get articles
    final url = Uri.parse('http://158.160.153.243:8000/knowledge-base/search-article/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"searchString": query});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      List<Article> items = _decodeArticles(response);
      ref.read(searchResultProvider.notifier).searchResultsA = items;
    } else {
      throw Exception('Failed to load search results');
    }

    // Get questions
    final url1 = Uri.parse('http://158.160.153.243:8000/qna/search-question/');
    final headers1 = {'Content-Type': 'application/json'};
    final body1 = jsonEncode({"searchString": query});
    final response1 = await http.post(url1, headers: headers1, body: body1);

    if (response1.statusCode == 200) {
      List<QA> items = _decodeQuestions(response1);
      ref.read(searchResultProvider.notifier).searchResultsQ = items;
    } else {
      throw Exception('Failed to load search results');
    }

    setState(() {
      _isSearching = false;
    });
  }

  List<Article> _decodeArticles(dynamic response) {
    final List<Article> data = [];
    try {
      var jsonData = jsonDecode(response.body);
      for (var itemData in jsonData) {
        String? id = itemData['id'] as String?;

        List<String>? tags;

        if (itemData.containsKey('tags') && itemData['tags'] != null) {
          var dynamicTags = itemData['tags'];
          tags = (dynamicTags as List<dynamic>).map((tag) => tag.toString()).toList();
        } else {
          tags = [];
        }

        String? title = itemData['title'] as String?;
        String? text = itemData['text'] as String?;
        List<Operation> ops = (itemData['content']['ops'] as List)
            .map((op) => Operation(
                  insert: op['insert'] ?? '',
                  attributes: op['attributes'] ?? {},
                ))
            .toList();
        Content content = Content(ops: ops);

        data.add(Article(
          id: id,
          tags: tags,
          title: title,
          text: text,
          content: content,
        ));
      }
      return data.toList();
    } catch (e) {
      throw Exception('Null data');
    }
  }

  List<QA> _decodeQuestions(dynamic response) {
    final List<QA> data = [];
    try {
      var jsonData = jsonDecode(response.body);
      for (var itemData in jsonData) {
        String? quest = itemData['question'] as String?;
        String? ans = itemData['answer'] as String?;
        data.add(QA(
          headerText: quest,
          expandedText: ans,
        ));
      }
      return data.toList();
    } catch (e) {
      throw Exception('Null data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final searchResults = ref.watch(searchResultProvider).searchResultsA;
        final questions = ref.watch(searchResultProvider).searchResultsQ;
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
                    prefixIcon: Icon(Icons.search),
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
                          itemCount: searchResults.length + questions.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < questions.length) {
                              return ExpansionTile(
                                title: Text(questions[index].headerText ?? ''),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(questions[index].expandedText ?? ''),
                                  ),
                                ],
                              );
                            } else if (index < searchResults.length + questions.length) {
                              return Column(
                                children: [
                                  const SizedBox(height: 5),
                                  ArticleCard(
                                    id: searchResults[index - questions.length].id,
                                    tags: searchResults[index - questions.length].tags,
                                    title: searchResults[index - questions.length].title,
                                    text: searchResults[index - questions.length].text,
                                    content: searchResults[index - questions.length].content,
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