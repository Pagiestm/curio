import '../entities/article.dart';

/// Interface définissant les opérations sur les articles
abstract class ArticleRepository {
  Future<Article?> getArticle(String id);
  Future<List<Article>> getArticles();
  Future<void> clearHistory();
}