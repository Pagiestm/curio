enum ReactionType {
  sad('sad', '😢'),
  angry('angry', '😠'),
  happy('happy', '😊'),
  funny('funny', '😄');

  final String value;
  final String emoji;

  const ReactionType(this.value, this.emoji);

  static ReactionType fromString(String value) {
    return ReactionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ReactionType.happy,
    );
  }
}

class Favorite {
  final int? id;
  final String articleId;
  final String articleTitle;
  final String articleDescription;
  final String articleUrlImage;
  final String articleAuthor;
  final DateTime articlePublishedAt;
  final ReactionType reaction;
  final DateTime createdAt;

  Favorite({
    this.id,
    required this.articleId,
    required this.articleTitle,
    required this.articleDescription,
    required this.articleUrlImage,
    required this.articleAuthor,
    required this.articlePublishedAt,
    required this.reaction,
    required this.createdAt,
  });

  // Convert from Map to Favorite
  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] as int?,
      articleId: map['articleId'] as String,
      articleTitle: map['articleTitle'] as String,
      articleDescription: map['articleDescription'] as String,
      articleUrlImage: map['articleUrlImage'] as String,
      articleAuthor: map['articleAuthor'] as String,
      articlePublishedAt: DateTime.parse(map['articlePublishedAt'] as String),
      reaction: ReactionType.fromString(map['reaction'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  // Convert from Favorite to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articleId': articleId,
      'articleTitle': articleTitle,
      'articleDescription': articleDescription,
      'articleUrlImage': articleUrlImage,
      'articleAuthor': articleAuthor,
      'articlePublishedAt': articlePublishedAt.toIso8601String(),
      'reaction': reaction.value,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a copy with updated fields
  Favorite copyWith({
    int? id,
    String? articleId,
    String? articleTitle,
    String? articleDescription,
    String? articleUrlImage,
    String? articleAuthor,
    DateTime? articlePublishedAt,
    ReactionType? reaction,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      articleTitle: articleTitle ?? this.articleTitle,
      articleDescription: articleDescription ?? this.articleDescription,
      articleUrlImage: articleUrlImage ?? this.articleUrlImage,
      articleAuthor: articleAuthor ?? this.articleAuthor,
      articlePublishedAt: articlePublishedAt ?? this.articlePublishedAt,
      reaction: reaction ?? this.reaction,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
