import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import '../../../models/itemkb_model.dart';

class ArticlePage extends StatefulWidget {
  final String? id;
  final List<String>? tags;
  final String? title;
  final String? text;
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
  State<ArticlePage> createState() => _ArticlePageState(this);
}

class _ArticlePageState extends State<ArticlePage> {
  late ArticlePage item;
  _ArticlePageState(this.item);

  @override
  Widget build(BuildContext context) {
    String fullText = item.content.ops.map((op) => op.insert).join(" ");

    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: 'Article',
        appBarHeight: 70,
      ),
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.title != null && item.title!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (item.tags != null && item.tags!.isNotEmpty)
                    Wrap(
                      spacing: 6.0,
                      children: item.tags!
                          .map((tag) => Chip(
                                label: Text(tag),
                                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                              ))
                          .toList(),
                    ),
                  const Divider(
                    color: Colors.blueGrey,
                    thickness: 2,
                    height: 20,
                  ),
                ],
              ),

            Text(
              fullText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        index: 1,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';


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

