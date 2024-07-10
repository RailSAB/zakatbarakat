import 'dart:convert';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:http/http.dart' as http;


  Future<List<Article>> getArticles() async {
  final List<Article> articles = [];
    try {
      final response = await http.get(Uri.parse('http://158.160.153.243:8000/knowledge-base/get-articles'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (var itemData in jsonData) {
          String? id = itemData['id'] as String?;
        
        List<String>? tags;

        if (itemData.containsKey('tags') && itemData['tags']!= null) {
          var dynamicTags = itemData['tags'];
          tags = (dynamicTags as List<dynamic>).map((tag) => tag.toString()).toList();
        } else {
          tags = [];
        } 
        
          String? title = itemData['title'] as String?;
          String? text = itemData['text'] as String?;
          List<Operation> ops = (itemData['content']['ops'] as List)
            .map((op) => Operation(insert: op['insert']?? '', attributes: op['attributes']?? {},))
            .toList();
          Content content = Content(ops: ops);

          articles.add(Article(
            id: id,
            tags: tags,
            title: title,
            text: text,
            content: content,
          ));
        }
        return articles.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Null data');
    }
  }