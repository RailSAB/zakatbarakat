import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/article.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/ui/pages/knowledge_base/article_page.dart';

class KBPage extends ConsumerStatefulWidget {
  const KBPage({super.key});

  @override
  ConsumerState<KBPage> createState() => _KBState();
}

class Item {
  final String id;
  final List<String> tags;
  final String title;
  final String text;
  final Content content;

  Item({
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content,
  });
}


class _KBState extends ConsumerState<KBPage> {
  final List<Item> _data = [];

  Future getData() async {
  final response = await http.get(Uri.parse('http://158.160.153.243:8000/knowledge-base/get-articles'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);

    for (var itemData in jsonData) {
      String id = itemData['id'];
      List<String> tags = List<String>.from(itemData['tags']);
      String title = itemData['title'];
      String text = itemData['text'];
      List<Operation> ops = (itemData['content']['ops'] as List)
        .map((op) => Operation(insert: op['insert'], attributes: op['attributes']))
        .toList();
      Content content = Content(ops: ops);

      _data.add(Item(
        id: id,
        tags: tags,
        title: title,
        text: text,
        content: content,
      ));
    }
  } else {
    throw Exception('Failed to load data');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Knowledge Base'),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding around the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(height: 5,),
                            Article(
                              id: _data[index].id,
                              tags: _data[index].tags,
                              title: _data[index].title,
                              text: _data[index].text,
                              content: _data[index].content,
                            ),
                            const SizedBox(height: 5,),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            ),
          ],
        ),
      ),
    );
  }
}
