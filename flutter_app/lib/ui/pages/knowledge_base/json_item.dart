import 'dart:convert';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:http/http.dart' as http;


  Future<List<Article>> getArticles() async {
  final List<Article> _articles = [];
    try {
      final response = await http.get(Uri.parse('http://158.160.153.243:8000/knowledge-base/get-articles'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // print('Total Items: ${jsonData.length}');

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

          _articles.add(Article(
            id: id,
            tags: tags,
            title: title,
            text: text,
            content: content,
          ));
        }
        return _articles.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Null data');
    }
  }

  Future<List<QA>> getQuestions() async {
  final List<QA> questions = [];
  final response = await http.get(Uri.parse('http://158.160.153.243:8000/qna/get-questions'));
  try {
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        String headerText = item["question"];
        String expandedText = item["answer"];

        questions.add(QA(
          headerText: headerText,
          expandedText: expandedText,
        ));
      }
      return questions.toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e.toString());
    throw Exception('Null data');
  }
}