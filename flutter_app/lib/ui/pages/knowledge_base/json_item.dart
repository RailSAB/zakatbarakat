import 'dart:convert';
import 'package:http/http.dart' as http;


class Content {
  final List<Operation> ops;

  Content({required this.ops});
}

class Operation {
  final String insert;
  final Map<String, dynamic> attributes;

  Operation({required this.insert, required Map<String, dynamic> attributes})
      : attributes = attributes.isNotEmpty? attributes : {};

  // Factory constructor for backward compatibility or other use cases
  factory Operation.fromMap(String insert, Map<String, dynamic>? attributes) {
    return Operation(
      insert: insert,
      attributes: attributes?? {}, // Ensures attributes is never null
    );
  }
}

class Item {

  final String? id;
  final List<String>? tags;
  final String? title;
  final String? text;
  final Content content;

  Item({
    this.id,
    this.tags,
    this.title,
    this.text,
    required this.content,
  });
}


Future<List<Item>> getData() async {
  final List<Item> _data = [];
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

          _data.add(Item(
            id: id,
            tags: tags,
            title: title,
            text: text,
            content: content,
          ));
        }
        return _data.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Null data');
    }
  }