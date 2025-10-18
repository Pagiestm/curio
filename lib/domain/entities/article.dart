class Article {
  final String id;
  final String title;
  final String description;
  final String category;
  final String content;
  final String urlImage;
  final String author;
  final DateTime publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.content,
    required this.urlImage,
    required this.author,
    required this.publishedAt,
  });

  // Convert from JSON to Article
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      urlImage: json['urlImage']?.toString() ?? '',
      author: json['author']?.toString() ?? 'Auteur inconnu',
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  // Convert from ArticleModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'content': content,
      'urlImage': urlImage,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}