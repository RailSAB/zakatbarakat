import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart'; 
import '../../../models/article_m.dart';

class ArticlePage extends StatefulWidget {
  final String id;
  final List<String> tags;
  final String title;
  final String text;
  final Content content;

  const ArticlePage({
    super.key,
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content,
  });

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late quill.QuillController _quillController;
  late TextEditingController _titleController;
  late List<TextEditingController> _tagControllers;

  @override
  void initState() {
    super.initState();
    settings();
  }

  void settings() {
    _titleController = TextEditingController(text: widget.title);
    _tagControllers = widget.tags.map((tag) => TextEditingController(text: tag)).toList();

    final jsonContent = widget.content.toJson();
    final ops = jsonContent['ops'] as List;
    _quillController = quill.QuillController(
      document: quill.Document.fromJson(ops),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _quillController.readOnly = true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _tagControllers) {
      controller.dispose();
    }
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          elevation: 4,  
          shadowColor: Colors.grey.withOpacity(0.5),
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
              controller: _quillController,
              showCursor: false,
          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}