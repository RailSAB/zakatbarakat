import 'package:json_annotation/json_annotation.dart';

part 'article_m.g.dart';

@JsonSerializable()
class Article {
  final String id;
  final List<String> tags;
  final String title;
  final String text;
  final Content content;

  Article({
    required this.id,
    required this.tags,
    required this.title,
    required this.text,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Content {
  final List<ContentItem> ops;

  Content({required this.ops});

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class ContentItem {
  final String? insert;
  final Map<String, dynamic>? attributes;

  ContentItem({this.insert, this.attributes});

  factory ContentItem.fromJson(Map<String, dynamic> json) => _$ContentItemFromJson(json);
  Map<String, dynamic> toJson() => _$ContentItemToJson(this);
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