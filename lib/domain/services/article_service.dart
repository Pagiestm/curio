import '../entities/article.dart';
import '../repositories/article_repository.dart';

class ArticleService {
  final ArticleRepository _repository;

  ArticleService(this._repository);

  Future<Article?> getArticle(String id) async {
    return await _repository.getArticle(id);
  }

  Future<List<Article>> getArticles() async {
    return await _repository.getArticles();
  }

  Future<void> clearHistory() async {
    await _repository.clearHistory();
  }
}