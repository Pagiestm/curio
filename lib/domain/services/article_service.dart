import '../entities/article.dart';
import '../repositories/article_repository.dart';

class ArticleService {
  final ArticleRepository _repository;

  ArticleService(this._repository);

  Future<Article?> getArticle(String id) async {
    return await _repository.getArticle(id);
  }

  Future<List<Article>> getArticles(String languageCode) async {
    return await _repository.getArticles(languageCode);
  }

  Future<List<Article>> getArticlesByKeyword(
    String keyword,
    String languageCode,
  ) async {
    return await _repository.getArticlesByKeyword(keyword, languageCode);
  }

  Future<void> clearArticles() async {
    await _repository.clearArticles();
  }
}
