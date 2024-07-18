// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';
// import '../../../models/itemkb_model.dart';

// class ArticlePage extends StatefulWidget {
//   final String? id;
//   final List<String>? tags;
//   final String? title;
//   final String? text;
//   final Content content;

//   const ArticlePage({
//     super.key,
//     required this.id,
//     required this.tags,
//     required this.title,
//     required this.text,
//     required this.content,
//   });

//   @override
//   State<ArticlePage> createState() => _ArticlePageState(this);
// }

// class _ArticlePageState extends State<ArticlePage> {
//   late ArticlePage item;
//   _ArticlePageState(this.item);

//   @override
//   Widget build(BuildContext context) {
//     String fullText = item.content.ops.map((op) => op.insert).join(" ");

//     return Scaffold(
//       appBar: CustomAppBar(
//         pageTitle: 'Article',
//         appBarHeight: 70,
//       ),
//       backgroundColor: const Color(0xFFF0F4F8),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (item.title != null && item.title!.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.title!,
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   if (item.tags != null && item.tags!.isNotEmpty)
//                     Wrap(
//                       spacing: 6.0,
//                       children: item.tags!
//                           .map((tag) => Chip(
//                                 label: Text(tag),
//                                 backgroundColor: Colors.blue[100],
//                               ))
//                           .toList(),
//                     ),
//                   const Divider(
//                     color: Colors.blueGrey,
//                     thickness: 2,
//                     height: 20,
//                   ),
//                 ],
//               ),

//             Text(
//               fullText,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(
//         index: 1,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';

// import '../../../models/itemkb_model.dart';


// class ArticlePage extends StatefulWidget {
//   final String? id;
//   final List<String>? tags;
//   final String? title;
//   final String? text;
//   final Content content;

//   const ArticlePage(
//     {super.key,
//     required this.id,
//     required this.tags,
//     required this.title,
//     required this.text,
//     required this.content});

//   @override
//   State <ArticlePage> createState() => _ArticlePageState(this);
// }

// class _ArticlePageState extends State <ArticlePage> {

//   late ArticlePage item;
//   _ArticlePageState(this.item);

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: CustomAppBar(pageTitle: 'Article', appBarHeight: 70,),
//       backgroundColor: const Color.fromARGB(104, 200, 215, 231),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(item.title ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//             ...item.content.ops.map((op) {
//                 double fontSize = 16; // Default font size
//                 if (op.attributes!= {}) {
//                   if (op.attributes.containsKey('bold')) {
//                     return Text(
//                       op.insert,
//                       style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//                     );
//                 } else if (op.attributes.containsKey('header')) {
//                   fontSize += op.attributes['header'] as int;
//                 }
//               } 
//               return Text(
//                   op.insert,
//                   style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
//                );
//             }).toList(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(index: 1,),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';


// import '../../../models/itemkb_model.dart';
//  import 'package:flutter_app/ui/widgets/custom_app_bar.dart';


// class ArticlePage extends StatefulWidget {
//   final String? id;
//   final List<String>? tags;
//   final String? title;
//   final String? text;
//   final Content content;

//   const ArticlePage(
//     {super.key,
//     required this.id,
//     required this.tags,
//     required this.title,
//     required this.text,
//     required this.content});

//   @override
//   State <ArticlePage> createState() => _ArticlePageState(this);
// }

// class _ArticlePageState extends State <ArticlePage> {

//   late ArticlePage item;
//   _ArticlePageState(this.item);

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: CustomAppBar(pageTitle: 'Article', appBarHeight: 70,),
//     backgroundColor: Colors.grey[200],
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(item.title ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//             ...item.content.ops.map((op) {
//                 double fontSize = 16; // Default font size
//                 if (op.attributes!= {}) {
//                   if (op.attributes.containsKey('bold')) {
//                     return Text(
//                       op.insert,
//                       style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//                     );
//                 } else if (op.attributes.containsKey('header')) {
//                   fontSize += op.attributes['header'] as int;
//                 }
//               } 
//               return Text(
//                   op.insert,
//                   style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
//                );
//             }).toList(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(index: 1,),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
import 'package:flutter_quill/flutter_quill.dart'; 
import '../../../models/article_m.dart';

class ArticlePage extends StatefulWidget {
  final String id;
  final List<String> tags;
  final String title;
  final String text;
  final Content content;

  const ArticlePage({
    Key? key,
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content,
  }) : super(key: key);

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: _titleController,
            //   decoration: const InputDecoration(labelText: 'Title'),
            // ),
            Wrap(
              spacing: 8.0,
              children: _tagControllers.map((controller) {
                return Chip(
                  label: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      // hintText: 'Tag',
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
         controller: _quillController,
         
          ),

         
 
              ),
            ),
          ],
        ),
      ),
    );
  }
}