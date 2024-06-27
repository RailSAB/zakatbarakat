import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/knowledge_base/kb_main_frame.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

//----------------- markdown classes -----------------------
class Content {
  final List<Operation> ops;

  Content({required this.ops});
}

class Operation {
  final String insert;
  final Map<String, dynamic> attributes;

  Operation({required this.insert, required this.attributes});
}
//----------------- markdown classes -----------------------


class ArticlePage extends StatefulWidget {
  final String id;
  final List<String> tags;
  final String title;
  final String text;
  final Content content;

  const ArticlePage(
    {super.key,
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content});

  @override
  State <ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State <ArticlePage> {
  late Item item; // Assume this is initialized somewhere

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
            ),
           ...item.content.ops.map((op) {
              if (op.attributes.containsKey('bold')) {
                return Text(
                  op.insert,
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              } else if (op.attributes.containsKey('header')) {
                // Simplified header handling. For actual headings, consider using a package like flutter_markdown.
                return Text(
                  op.insert,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              } else {
                return Text(op.insert);
              }
            }).toList(),
          ],
        ),
      ),
    );
  }
}





/*
extension MarkdownParser on String {
  TextStyle getMarkdownStyle(String input) {
    final RegExp regex = RegExp(r'<style>(.*?)</style>');
    final Iterable<RegExpMatch> matches = regex.allMatches(input);
    final List<TextStyle> styles = [];
    
    for (final match in matches) {
      final style = match.group(1)!;
      switch (style) {
        case 'bold':
          styles.add(const TextStyle(fontWeight: FontWeight.bold));
          break;
        case 'italic':
          styles.add(const TextStyle(fontStyle: FontStyle.italic));
          break;
        default:
          break;
      }
    }
    
    return styles.isNotEmpty? styles.last : const TextStyle(); 
  }
}
*/