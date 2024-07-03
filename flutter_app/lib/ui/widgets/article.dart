import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemkb_model.dart';
import 'package:flutter_app/ui/pages/knowledge_base/article_page.dart';


class ArticleCard extends StatelessWidget {
   
  final String? id;
  final List<String>? tags;
  final String? title;
  final String? text;
  final Content content;

  const ArticleCard({
    super.key,
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content,
  });
  

  @override
  Widget build(BuildContext context) {
    
   
    return GestureDetector(
      onTap: () async {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticlePage(
            id: id,
            tags: tags,
            title: title,
            text: text,
            content: content,
          )),
        );
      },
      
      child: Material(
        
        borderRadius: BorderRadius.circular(16),
        elevation: 6,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5), 
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      text!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
          ),
        );
  }
}
