class Item{}

class QA {
  QA({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });

  String? headerText;
  String? expandedText;
  bool isExpanded;
}


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

// class Article extends Item{

//   final String? id;
//   final List<String>? tags;
//   final String? title;
//   final String? text;
//   final Content content;

//   Article({
//     this.id,
//     this.tags,
//     this.title,
//     this.text,
//     required this.content,
//   });
//}